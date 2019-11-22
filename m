Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 669AA106F38
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2019 12:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbfKVLOU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Nov 2019 06:14:20 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:53030 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729061AbfKVLOU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Nov 2019 06:14:20 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAMBDuZ6133216;
        Fri, 22 Nov 2019 11:13:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=GIxifyYdtbmQt1tL7yec0fFzEwAr/ycRNTaVOVktwxo=;
 b=i8+W8I7Dcowz2rZWQo/fHzHZmpTHkIEDXHjygLihGuslHKXSd5kV80JnuaPcK3bJO6qj
 +lR0opwgvd6ZFPHqulpOGZnMfMpllu/ohI4KW3DDRB3ocFDQSB9s0Tl+Jq2333jSPWHT
 P8ZQQjbofqBc9JIL4u02fgVRfO1vpL9X05ZgPbJ/u76wMXAga7KhWI8dN7dpuU6xyy46
 CXFeC5DEJHloSVtA3sXpdKTt8diNQwUzTGMwkldz3G4X73nCLR4DHvw2JuupjJ7jh7Uj
 vyj4+a9P3iWGHAqL1S9Nv7wSOEaSFYibgXJSws6jfuFOgbFze1eN7uUSEDXkBVOY1GWV hg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2wa9rr1wj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Nov 2019 11:13:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAMBDotW088000;
        Fri, 22 Nov 2019 11:13:55 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2wec28qea1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Nov 2019 11:13:55 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAMBDrK8015571;
        Fri, 22 Nov 2019 11:13:53 GMT
Received: from kadam (/41.210.154.155)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 22 Nov 2019 03:13:51 -0800
Date:   Fri, 22 Nov 2019 14:13:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     qize wang <wangqize888888888@gmail.com>
Cc:     linux-wireless@vger.kernel.org, amitkarwar <amitkarwar@gmail.com>,
        nishants <nishants@marvell.com>, gbhat <gbhat@marvell.com>,
        huxinming820 <huxinming820@gmail.com>,
        kvalo <kvalo@codeaurora.org>, Greg KH <greg@kroah.com>,
        security <security@kernel.org>,
        linux-distros <linux-distros@vs.openwall.org>,
        Solar Designer <solar@openwall.com>
Subject: Re: [PATCH] mwifiex: Fix heap overflow in
 mmwifiex_process_tdls_action_frame()
Message-ID: <20191122111339.GH617@kadam>
References: <E40E893E-D9B4-4C63-8139-1DD5E1C2CECB@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E40E893E-D9B4-4C63-8139-1DD5E1C2CECB@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9448 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911220101
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9448 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911220101
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Nov 22, 2019 at 05:43:49PM +0800, qize wang wrote:
> 		case WLAN_EID_HT_CAPABILITY:
> -			memcpy((u8 *)&sta_ptr->tdls_cap.ht_capb, pos,
                                                                ^^^^
> +			if (pos > end - sizeof(struct ieee80211_ht_cap) - 2)
> +				return;
> +			if (pos[1] != sizeof(struct ieee80211_ht_cap))
> +				return;
> +			/* copy the ie's value into ht_capb*/
> +			memcpy((u8 *)&sta_ptr->tdls_cap.ht_capb, pos + 2,
                                                                 ^^^^^^^

I don't understand why we changed "pos" to "pos + 2".  Presumably there
is a reason, but it needs to explained in the commit message.


> 			       sizeof(struct ieee80211_ht_cap));
> 			sta_ptr->is_11n_enabled = 1;
> 			break;
> 		case WLAN_EID_HT_OPERATION:
> -			memcpy(&sta_ptr->tdls_cap.ht_oper, pos,
                                                           ^^^
> +			if (pos > end -
> +			    sizeof(struct ieee80211_ht_operation) - 2)
> +				return;
> +			if (pos[1] != sizeof(struct ieee80211_ht_operation))
> +				return;
> +			/* copy the ie's value into ht_oper*/
> +			memcpy(&sta_ptr->tdls_cap.ht_oper, pos + 2,
                                                           ^^^^^^^

> 			       sizeof(struct ieee80211_ht_operation));
> 			break;
> 		case WLAN_EID_BSS_COEX_2040:
> +			if (pos > end - 3)
> +				return;
> +			if (pos[1] != 1)
> +				return;
> 			sta_ptr->tdls_cap.coex_2040 = pos[2];
> 			break;
> 		case WLAN_EID_EXT_CAPABILITY:
> +			if (pos > end - sizeof(struct ieee_types_header))
> +				return;
> +			if (pos[1] < sizeof(struct ieee_types_header))
> +				return;
> +			if (pos[1] > 8)
> +				return;
> 			memcpy((u8 *)&sta_ptr->tdls_cap.extcap, pos,
> 			       sizeof(struct ieee_types_header) +
> 			       min_t(u8, pos[1], 8));
> 			break;
> 		case WLAN_EID_RSN:
> +			if (pos > end - sizeof(struct ieee_types_header))
> +				return;
> +			if (pos[1] < sizeof(struct ieee_types_header))
> +				return;
> +			if (pos[1] > IEEE_MAX_IE_SIZE -
> +			    sizeof(struct ieee_types_header))
> +				return;
> 			memcpy((u8 *)&sta_ptr->tdls_cap.rsn_ie, pos,
> 			       sizeof(struct ieee_types_header) +
> 			       min_t(u8, pos[1], IEEE_MAX_IE_SIZE -
> 				     sizeof(struct ieee_types_header)));
> 			break;
> 		case WLAN_EID_QOS_CAPA:
> +			if (pos > end - 3)
> +				return;
> +			if (pos[1] != 1)
> +				return;
> 			sta_ptr->tdls_cap.qos_info = pos[2];
> 			break;
> 		case WLAN_EID_VHT_OPERATION:
> -			if (priv->adapter->is_hw_11ac_capable)
> -				memcpy(&sta_ptr->tdls_cap.vhtoper, pos,
                                                                   ^^^

> +			if (priv->adapter->is_hw_11ac_capable) {
> +				if (pos > end -
> +				    sizeof(struct ieee80211_vht_operation) - 2)
> +					return;
> +				if (pos[1] !=
> +				    sizeof(struct ieee80211_vht_operation))
> +					return;
> +				/* copy the ie's value into vhtoper*/
> +				memcpy(&sta_ptr->tdls_cap.vhtoper, pos + 2,
                                                                   ^^^^^^^
> 				       sizeof(struct ieee80211_vht_operation));
> +			}
> 			break;
> 		case WLAN_EID_VHT_CAPABILITY:
> 			if (priv->adapter->is_hw_11ac_capable) {
> -				memcpy((u8 *)&sta_ptr->tdls_cap.vhtcap, pos,
                                                                        ^^^

> +				if (pos > end -
> +				    sizeof(struct ieee80211_vht_cap) - 2)
> +					return;
> +				if (pos[1] != sizeof(struct ieee80211_vht_cap))
> +					return;
> +				/* copy the ie's value into vhtcap*/
> +				memcpy((u8 *)&sta_ptr->tdls_cap.vhtcap, pos + 2,
                                                                        ^^^^^^^

> 				       sizeof(struct ieee80211_vht_cap));
> 				sta_ptr->is_11ac_enabled = 1;
> 			}
> 			break;

I was confused by the "- 2" as well in the earlier versions of this
patch but Marvell approved it so I assumed it was correct.  It would be
nice if this patch were tested.

regards,
dan carpenter

