Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C793164A8
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 12:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbhBJLJa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 06:09:30 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:48930 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbhBJLHm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 06:07:42 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11AB3vkn070173;
        Wed, 10 Feb 2021 11:06:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=G9fKkdKNDzG7QxPRbMQjQRCZPh/j3pVch3ROKGju7X4=;
 b=OeUvbpKPjuibu8PmS3s20DhUVGhVV3+hjz+nFxLB6cjF5z7ERPr3fYRmTVm0penu+SQE
 SZUN5Ni0EgPLIX26kAi5HsZ529FmQ6l0+5G1wNxhMuopFw/1oh3UUqiiHvJH2MP8eY9/
 FjxVYBsb9EH08zZyP1gp4sBySKE20lGkCfcUEWsUS0bcz1feVyjBzAR0ffyQEmXhlFjv
 MHL/bre5JR6KhcSMDD5h0cpAouxLPloGelAmulzkOkVF1B0CKo7JxfqysK+PbsdU8eX+
 V3wC3L9INRbskHAvQ3j3RY1ULlaxeYUdThGxzGi0Hjd+OmsjJ7+r6BeMxHfi8h7bXXwy 2g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 36hgmak2yc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 11:06:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11AB5Tmf106324;
        Wed, 10 Feb 2021 11:06:57 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 36j512gkgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 11:06:57 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 11AB6uw5001039;
        Wed, 10 Feb 2021 11:06:56 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Feb 2021 03:06:55 -0800
Date:   Wed, 10 Feb 2021 14:06:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     shayne.chen@mediatek.com
Cc:     linux-wireless@vger.kernel.org
Subject: [bug report] mt76: mt7915: add support for continuous tx in testmode
Message-ID: <YCO+SaK0nJvCG5J5@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=871 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102100109
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 clxscore=1011 mlxlogscore=812 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102100108
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Shayne Chen,

The patch 3f0caa3cbf94: "mt76: mt7915: add support for continuous tx
in testmode" from Jan 5, 2021, leads to the following static checker
warning:

	drivers/net/wireless/mediatek/mt76/mt7915/testmode.c:597 mt7915_tm_set_tx_cont()
	error: uninitialized symbol 'mode'.

drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
   583                  break;
   584          case MT76_TM_TX_MODE_HE_EXT_SU:
   585                  mode = MT_PHY_TYPE_HE_EXT_SU;
   586                  break;
   587          case MT76_TM_TX_MODE_HE_TB:
   588                  mode = MT_PHY_TYPE_HE_TB;
   589                  break;
   590          case MT76_TM_TX_MODE_HE_MU:
   591                  mode = MT_PHY_TYPE_HE_MU;
   592                  break;
   593          default:

"mode" is uninitialized on the default path.

   594                  break;
   595          }
   596  
   597          rateval =  mode << 6 | rate_idx;
                           ^^^^^^^^^

   598          tx_cont->rateval = cpu_to_le16(rateval);
   599  
   600  out:
   601          if (!en) {
   602                  int ret;
   603  

regards,
dan carpenter
