Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B767F860D1
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2019 13:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbfHHL0B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Aug 2019 07:26:01 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48610 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbfHHL0B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Aug 2019 07:26:01 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x78BDdmn090787;
        Thu, 8 Aug 2019 11:25:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=3Lsk/V9qul0wY9Uf7ZUNUVa+w3fwbn2eUiZj6cS5F18=;
 b=cxfPdmiI4idPFVpqqiIQc2sKbLA9BXCmRSLRBjzrbzNHE922GCTS1yiZUjzRDcIZHYZ5
 L4fnv0AD52rin251pTw8CYxERo4BW1C1eEbnOA55OGW0ft+LIkN8BwbSEgAmlFZCPdhL
 /m1uwVu1FBEsoPjhSDNquBgTfqKHBgw6MKXC9AVIRUfSe3gsMx6XshJ2NfZ+WqLoWKrW
 2FAsPuCPSheDkhA/YEnR/ttZN1CjmXYbn+yjZWaSrzuxyAomUf5OzcXAaDIhdeq+1hWJ
 9UXgLSa3Iw65GxpNmxYvKaP+IBLhFKERgznZBKo+z+V7xcouHn9KHeff/6/aVFwoC0pM /w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=3Lsk/V9qul0wY9Uf7ZUNUVa+w3fwbn2eUiZj6cS5F18=;
 b=c5s98OLZX6zdBh8XYppPq9AibpcjGMxjIL0OvHfq/nvUMfHpxmEts+FdiA1alAGVDApB
 26GPOjfTkGUOTaN1wBUsfLmcknIex2+CtmRnBVlG+TjKeZhgSK8+EEsDwO3d1h4imAVs
 gTwqgRxsQ+p93t6WIURmZdaUZBd63RBZF2iRreOA8J1bskymHTNWhp2VsO7bYzPtl8ba
 PSOzMMc7dBGs/+oxBI1a+Be5hd/jH78U4ZpKnK1CoI+yYK8ZwRWro76PwCungG24pYEk
 3KHGMdT7P+EtYMxzW7ET8t6G3NSas9ZLaTvoyBfiXZ2MHPmv+fCPp97ZENToXE+oboHm 0Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2u8has8khj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Aug 2019 11:25:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x78BDrQ4126976;
        Thu, 8 Aug 2019 11:25:57 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2u75bxhhp1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Aug 2019 11:25:56 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x78BPuup000518;
        Thu, 8 Aug 2019 11:25:56 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 08 Aug 2019 04:25:55 -0700
Date:   Thu, 8 Aug 2019 14:25:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     john@phrozen.org
Cc:     linux-wireless@vger.kernel.org
Subject: [bug report] mac80211: allow setting spatial reuse parameters from
 bss_conf
Message-ID: <20190808112550.GA15648@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9342 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=938
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908080122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9342 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=994 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908080122
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello John Crispin,

This is a semi-automatic email about new static checker warnings.

The patch 1ced169cc1c2: "mac80211: allow setting spatial reuse
parameters from bss_conf" from Jul 30, 2019, leads to the following
Smatch complaint:

    net/mac80211/he.c:79 ieee80211_he_spr_ie_to_bss_conf()
    warn: variable dereferenced before check 'he_spr_ie_elem' (see line 75)

net/mac80211/he.c
    69  void
    70  ieee80211_he_spr_ie_to_bss_conf(struct ieee80211_vif *vif,
    71                                  const struct ieee80211_he_spr *he_spr_ie_elem)
    72  {
    73          struct ieee80211_he_obss_pd *he_obss_pd =
    74						&vif->bss_conf.he_obss_pd;
    75		const u8 *data = he_spr_ie_elem->optional;
                                 ^^^^^^^^^^^^^^^^^^^^^^^^
Dereference.

    76	
    77		memset(he_obss_pd, 0, sizeof(*he_obss_pd));
    78	
    79		if (!he_spr_ie_elem)
                    ^^^^^^^^^^^^^^^
Checked too late.

    80			return;
    81	

regards,
dan carpenter
