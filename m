Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6625D1D0A92
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2020 10:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbgEMINd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 May 2020 04:13:33 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47420 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgEMINc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 May 2020 04:13:32 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04D88Lrg005188;
        Wed, 13 May 2020 08:13:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=ax0j26Qez9eBRtMmFc586ytztVig5XUVKr6NUdGKGB4=;
 b=hNh0fal6iHbhT24ibRhSlaR/64mDUnbW1HTzX0SUlEk0LRs1IHolXkuQiEwc5MeTR0ER
 XCfuPuPWgQeOgZZLfAWr8rpL5vZCEJQ9m/qpmq6MfWMoLdK37LI8vIkqFhl3QGxHykIh
 G7NbTlkArPRksHKErLJghb6s+V2r6LZ08amm018ada8vpegt8h/XpljE9hy+dhEe27+p
 6OrYZDxZ598TvyqToNPqbAiLykLTYqZPMCB9zFngr2b4EFCcgxZiPNisYuZJmjotqprf
 jqqG0Kvw0jT+LWaDbhyuDOI9wzcgC0Mf+aj/Y68mJk428ccqxbZPAxCgg4XhuMeG6wU1 YQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 3100yftpn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 May 2020 08:13:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04D88UFX099799;
        Wed, 13 May 2020 08:11:25 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 3100ykkjpp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 May 2020 08:11:25 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04D8BOTN013695;
        Wed, 13 May 2020 08:11:24 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 May 2020 01:11:23 -0700
Date:   Wed, 13 May 2020 11:11:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Malcolm Priestley <tvboxspy@gmail.com>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oscar Carter <oscar.carter@gmx.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 2/6] staging: vt6656: vnt_get_rtscts_duration_le use
 ieee80211_rts_duration
Message-ID: <20200513081117.GC2078@kadam>
References: <377a4cc3-cfe3-91aa-cf71-1063f311426a@gmail.com>
 <20200513080758.GB2078@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513080758.GB2078@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9619 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005130075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9619 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 cotscore=-2147483648 mlxscore=0 suspectscore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005130075
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Btw, I don't know if this has already been applied.  I'm fine with
applying it as-is.  The code doesn't hurt anything and it disappears
later in the series anyways.

I only mentioned this about fall through for future reference.

regards,
dan carpenter

