Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78CC33090E
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Mar 2021 08:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbhCHH6S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Mar 2021 02:58:18 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:46784 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbhCHH5y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Mar 2021 02:57:54 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1287ovnQ068919;
        Mon, 8 Mar 2021 07:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Lrcw+FZfsit4eFSZciuvd/71ULyoUJnUtSObUGTnrrY=;
 b=pLt0u0C5Zrt0adAM+mBIRCDXbS0pj9gHdBlzO+hHYDLd8tEjJv3959RR8K7OMHVJ4A0n
 e0XINAkQd1fuEEpYUGzTUwow6D3twqkEC9qEY2DnklUx2ZyPR/dN+Spz+ueiz6X2STuQ
 nHnnkd8B9UlBqkKF9X6NaV1k/JVNOSBJguqY6T54+081cYnTBlEKY+4jBHxtvqJYWbsz
 GT4owCRO50h17sUQ7UeSxd+zKcU81U4kJOedieKyiqwDRztZHg+W4Zp4YD/VntJMUs5a
 HQTFdMtaIQSTt+uFyDjnGRmzIBbnoP0Qcgq5Vn+AxJO9WE+gHjrf0eTK/D9ls/Tp/uvh fQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 37415r2nwu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Mar 2021 07:57:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1287otbF111865;
        Mon, 8 Mar 2021 07:57:49 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 374kgpyw7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Mar 2021 07:57:49 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 1287vlVd022032;
        Mon, 8 Mar 2021 07:57:48 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Mar 2021 07:57:47 +0000
Date:   Mon, 8 Mar 2021 10:57:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Lee <leegib@gmail.com>
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: Fix possible buffer overflow in
 _rtl92e_wx_set_scan
Message-ID: <20210308075735.GA21246@kadam>
References: <20210226114829.316980-1-leegib@gmail.com>
 <20210226134333.GA2087@kadam>
 <20210226140526.GG2222@kadam>
 <20210301132535.GR2087@kadam>
 <20210305082228.GG2222@kadam>
 <20210305150014.GA627584@ubuntudesktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305150014.GA627584@ubuntudesktop>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9916 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103080041
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9916 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 adultscore=0
 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103080041
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Mar 05, 2021 at 03:00:14PM +0000, Lee wrote:
> 
> Hi Dan,
> 
> Do you think any of these could be potential issues:
> 
> driver/staging/
> 
> rtl8192e/rtllib_rx.c:2442

	memcpy(dst->ssid, src->ssid, src->ssid_len);

Smatch says that at this point we know "src->ssid_len" is in the 1-32
range.  This is without any fixes to how Smatch parses nl_len().

> wlan-ng/cfg80211.c:316

   313          if (request->n_ssids > 0) {
   314                  msg1.scantype.data = P80211ENUM_scantype_active;
   315                  msg1.ssid.data.len = request->ssids->ssid_len;
   316                  memcpy(msg1.ssid.data.data,
   317                         request->ssids->ssid, request->ssids->ssid_len);
   318          } else {

The only thing Smatch knows about "request->ssids->ssid_len" is that
it's 0-255.  I had not marked "msg1.ssid.data.data" as a protected
struct member so it didn't generate a warning.

I think cfg80211_scan_request structs are filled out in a systematic
way in ieee80211_request_ibss_scan() and they're bounds checked properly
so this isn't a bug.

> rtl8723bs/os_dep/ioctl_cfg80211.c:1591
> rtl8723bs/os_dep/ioctl_cfg80211.c:2738

Same.

regards,
dan carpenter

