Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC79F833FA
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2019 16:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731788AbfHFOaw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Aug 2019 10:30:52 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52264 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728756AbfHFOaw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Aug 2019 10:30:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x76EStdK145760;
        Tue, 6 Aug 2019 14:30:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=dklItruseSItxn5nFl+06+YXqvbaHv+bwchULkfwVaI=;
 b=hROo4I5cQXMXFzX4n8x9nzm1IKPCKrfZYKjqH7PYagAWmSsqv15ydsFZloisw8WfX+4J
 fT1xJV3akwYDk6Nd6j0D9siMcBaowiE+uuWH328zU311XfC43y6jTe7/ZXgzmDuaVs0a
 ulcuUM69KvpAVnDbShxQq9Vvv8bslsYabYs/7+HURj3WsggqjRyg92Fp+GrA9ef36Rnm
 c86VPRyvGFTsUsSSituAp6DLWPFdoYyk+L26bKvjEGDRjIa6dvau64Xn67ISTNnWVy7C
 z0wqErmk4icTIyuacZS1WI23duwekCEbnbc/rTjNIwK1HTsuJjSAKvlAW9AGIKIVxZaS Ew== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2u52wr6h8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Aug 2019 14:30:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x76EUioV065396;
        Tue, 6 Aug 2019 14:30:49 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2u75bvj1pu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Aug 2019 14:30:49 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x76EUlhR003626;
        Tue, 6 Aug 2019 14:30:47 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 06 Aug 2019 07:30:47 -0700
Date:   Tue, 6 Aug 2019 17:30:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     haim.dreyfuss@intel.com
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [bug report] iwlwifi: Add support for SAR South Korea limitation
Message-ID: <20190806143041.GG1935@kadam>
References: <20190806142435.GA13072@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806142435.GA13072@mwanda>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9340 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=546
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908060146
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9340 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=614 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908060146
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Oops.  There are a couple other related warnings as well.

drivers/net/wireless/intel/iwlwifi/fw/acpi.c:166 iwl_acpi_get_mcc() warn: passing a valid pointer to 'PTR_ERR'
drivers/net/wireless/intel/iwlwifi/fw/acpi.c:228 iwl_acpi_get_eckv() warn: passing a valid pointer to 'PTR_ERR'
drivers/net/wireless/intel/iwlwifi/mvm/fw.c:696 iwl_mvm_sar_get_wrds_table() warn: passing a valid pointer to 'PTR_ERR'
drivers/net/wireless/intel/iwlwifi/mvm/fw.c:733 iwl_mvm_sar_get_ewrd_table() warn: passing a valid pointer to 'PTR_ERR'
drivers/net/wireless/intel/iwlwifi/mvm/fw.c:793 iwl_mvm_sar_get_wgds_table() warn: passing a valid pointer to 'PTR_ERR'

regards,
dan carpenter


