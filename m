Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C885587EF5
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Aug 2022 17:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbiHBP2U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Aug 2022 11:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiHBP2T (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Aug 2022 11:28:19 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC02E23A
        for <linux-wireless@vger.kernel.org>; Tue,  2 Aug 2022 08:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659454097; x=1690990097;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6gUreZWXS7RFuUgvi3PWTMsFlduUcRgQ9BxL3rqd1DQ=;
  b=kNOJyxKi98RJ2eAqGcIbOyv1Yvek0NtcostfP7ETx/MFWZ7XFtf9juJ/
   dSdMRnNiWZwHtTaWJFSUfeBlT3NzOB7MzhssERAhBI949+58823jbHtgh
   NyTapGm9zEER4y2g6OYoDSww5IWrSvKCNdJKosm3mwvbQOepSs6ys9xQd
   0=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 02 Aug 2022 08:28:17 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 08:28:17 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 2 Aug 2022 08:28:16 -0700
Received: from [10.110.54.176] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 2 Aug 2022
 08:28:15 -0700
Message-ID: <29694008-63ef-4cd3-a6c6-f82fc8377be6@quicinc.com>
Date:   Tue, 2 Aug 2022 08:28:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC 1/2] wifi: mac80211: add a new field in ieee80211_rx_status
 for link id
Content-Language: en-US
To:     Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
        <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
References: <20220802065019.20791-1-quic_vthiagar@quicinc.com>
 <20220802065019.20791-2-quic_vthiagar@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220802065019.20791-2-quic_vthiagar@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/1/2022 11:50 PM, Vasanthakumar Thiagarajan wrote:
> In MLO, when the address translation from link to MLD is done
> in fw/hw, it is necessary to be able to have some information
> on the link on which the frame has been received. Extend the
> rx API to include link_id in ieee80211_rx_status.
> 
> Signed-off-by: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
> ---
>   include/net/mac80211.h | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/include/net/mac80211.h b/include/net/mac80211.h
> index f198af600b5e..23bc34657b16 100644
> --- a/include/net/mac80211.h
> +++ b/include/net/mac80211.h
> @@ -1480,6 +1480,9 @@ enum mac80211_rx_encoding {
>    *	each A-MPDU but the same for each subframe within one A-MPDU
>    * @ampdu_delimiter_crc: A-MPDU delimiter CRC
>    * @zero_length_psdu_type: radiotap type of the 0-length PSDU
> + * @link_id: id of the link used to receive the packet. Applicable only with
> + *	MLO connection, valid link ids are in 0-14, link_id 15 means either the
> + *	link id is not known or it is a non-MLO connection.
>    */
>   struct ieee80211_rx_status {
>   	u64 mactime;
> @@ -1504,6 +1507,7 @@ struct ieee80211_rx_status {
>   	s8 chain_signal[IEEE80211_MAX_CHAINS];
>   	u8 ampdu_delimiter_crc;
>   	u8 zero_length_psdu_type;
> +	u8 link_id;
>   };
>   
>   static inline u32

in other parts of the MLO code the link_id is defined as int and a value 
of -1 is used for a non-MLO link. but I don't know if that is currently 
universally true.

if that is curently universally true, do we want to now have divergent 
definitions of a link_id?

