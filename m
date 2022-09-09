Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5E25B31E6
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Sep 2022 10:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiIIIiv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Sep 2022 04:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbiIIIiu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Sep 2022 04:38:50 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0F812B344
        for <linux-wireless@vger.kernel.org>; Fri,  9 Sep 2022 01:38:47 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2898ZY3h009403;
        Fri, 9 Sep 2022 08:38:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=MTZg+QFCp+310+xmWkLK5EIEVZ44oLN/N7Dhe23gEvg=;
 b=PC1K5EzAarmXfqOzjzeZz2EDPwgwvA9FkmCrp4jGrg0RlksmYY4cw8+Tw63HusDZrGuc
 E4ltQbHmvDQQKKLiEcTnvTYMMrCjhrhCqX7PBhZk6JBsAZcZ3UQHKijzVvyD9pQY07VE
 ASDjcqRqLvGelYB3GXOzeIE8nCO5Kv3yqGlwseDLPGGzpg8E0+PSwEY3ojgxZruZvsQT
 AeOKOFSV8vPoJ/qV6WDqHvk8xG3N2XppVtuKSCetCVTRg5PFZF1JloMtuJkSffX1iNuQ
 HhFPdBpZ7GWWlWa0BwJxrYebzB01EyuVd4FKslh5Hg2sC9GwtHYYts3ZjrzBjmkMAfy9 Zg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jfdc7437a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 08:38:38 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2898cbsH021912
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Sep 2022 08:38:37 GMT
Received: from [10.231.195.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 9 Sep 2022
 01:38:36 -0700
Message-ID: <e036ea72-10b1-1d4c-023b-c7d248a72b86@quicinc.com>
Date:   Fri, 9 Sep 2022 16:38:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 10/27] wifi: mac80211: isolate driver from inactive links
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC:     <ath11k@lists.infradead.org>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
 <20220902161143.5ce3dad3be7c.I92e9f7a6c120cd4a3631baf486ad8b6aafcd796f@changeid>
 <5d82e564-86bf-c26b-077a-d0bc14e2d3c3@quicinc.com>
 <74f3eb848326607b15336c31a02bdd861ccafb47.camel@sipsolutions.net>
 <2de44394-cb93-7be4-481f-2d92788b8d28@quicinc.com>
 <351f74e0e1cd6e9724f97dbd042bdc5e04c44842.camel@sipsolutions.net>
 <c05780bc-864c-9323-499d-a8b1ba1c2ef2@quicinc.com>
 <545227cf18baac94ea8aa24dc08b250c47949541.camel@sipsolutions.net>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <545227cf18baac94ea8aa24dc08b250c47949541.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Jtz--6hQ1BmPlOyBcy1c1YvlCvYl7oTk
X-Proofpoint-ORIG-GUID: Jtz--6hQ1BmPlOyBcy1c1YvlCvYl7oTk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_04,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209090029
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/9/2022 3:28 PM, Johannes Berg wrote:
> Hi,
>
>>> No, they aren't, and shouldn't be.
>> IEEE P802.11be™/D2.0
>> 35.3.3 Multi-link device addressing
>> An MLD has an MLD MAC address that singly identifies the MLD.
>> Each STA affiliated with an MLD shall have a different MAC address.
>> NOTE 1—The MLD MAC address of an MLD might be the same as the MAC
>> address of one affiliated STA or different
>> from the MAC address of any affiliated STA.
> Right. I was over-simplifying, that was basically the "tl;dr" version of
> my statement, without the longer one ;-)
>
>> This means the MLD address can be same with one link.
> True.
>
>> I suggest to set primary link local addr same with MLD address for station.
> I wouldn't suggest that, but YMMV.
>
>> reason is:
>> When station up, one link interface of driver will be created with the
>> addr of struct ieee80211_vif,
>> it is used for scan and non-MLO connection.
>> If station start to do MLO connection now, then random local link addr
>> will be generated by below call stack.
>> for the 1st link. This lead driver must change the link interface local
>> address to this random addr.
> Well, that depends how you treat "address of an interface", no? I don't
> think there's really any need to "install" a MAC address to the NIC
> until you even start any kind of operation.
>
> True, if you cannot scan using the MLD address while you also have a
> different link address, you might be in trouble - but I find this
> unrealistic because you would want to be able to scan on any part of the
> hardware that is doing any of the links?
Scan probe request needs the local address, so we must fill one address 
to it.
And we use the same local address to scan for 2.4 GHz/5 GHz/6 GHz band.
>
>
> In any case, changing this makes the receive logic a bit different. You
> would have to ensure that your driver does indeed indicate the link a
> frame was received on, I think? Also, ieee80211_rx_for_interface() might
> have to change, something like the below maybe?
I looked the ieee80211_rx_for_interface(), it is to find struct 
link_sta_info with the source
address of an rx frame. For station, the hdr->addr2 means the address of 
the AP, so
the the change of mac80211/wireless will not effect the 
ieee80211_rx_for_interface().
Because it is the MLD/link address of the AP(maybe it is same addr for 
MLD/one link) when we use as station.
>
> If we just change the first link's address to the same as the MLD
> address without any changes then the code without the changes below
> would overwrite the link ID because it can find the link STA address,
> even if the device already did address translation. Of course this is
> only relevant if it does address translation w/o indicating the link,
> which it shouldn't ... hence the patch.
>
> In any case, I expect this will end up being some kind of driver policy,
> so I can imagine that we could make a relatively simple patch with a new
> method to let drivers set the link address that gets used. It cannot be
> changing the link address when it's added to the driver since this patch
> that this thread is based on means the driver doesn't get to know about
> the links until it's far too late (and even before this patch, the links
> were only created after assoc, when the link addresses were already sent
> to the AP)
>
> johannes
>
>
>
> diff --git a/include/net/mac80211.h b/include/net/mac80211.h
> index ac2bad57933f..648b2de8dd3e 100644
> --- a/include/net/mac80211.h
> +++ b/include/net/mac80211.h
> @@ -1482,7 +1482,8 @@ enum mac80211_rx_encoding {
>    * @ampdu_delimiter_crc: A-MPDU delimiter CRC
>    * @zero_length_psdu_type: radiotap type of the 0-length PSDU
>    * @link_valid: if the link which is identified by @link_id is valid. This flag
> - *	is set only when connection is MLO.
> + *	is set only when connection is MLO. Note that setting this also implies
> + *	address translation was done.
>    * @link_id: id of the link used to receive the packet. This is used along with
>    *	@link_valid.
>    */
> diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
> index a57811372027..963de5d880d7 100644
> --- a/net/mac80211/rx.c
> +++ b/net/mac80211/rx.c
> @@ -4946,22 +4946,24 @@ static void __ieee80211_rx_handle_8023(struct ieee80211_hw *hw,
>   static bool ieee80211_rx_for_interface(struct ieee80211_rx_data *rx,
>   				       struct sk_buff *skb, bool consume)
>   {
> -	struct link_sta_info *link_sta;
> +	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
>   	struct ieee80211_hdr *hdr = (void *)skb->data;
> +	struct link_sta_info *link_sta = NULL;
>   
>   	/*
> -	 * Look up link station first, in case there's a
> -	 * chance that they might have a link address that
> -	 * is identical to the MLD address, that way we'll
> -	 * have the link information if needed.
> +	 * Unless the driver did addr translation and provided the link
> +	 * ID, look up link station first. Note that if we get a frame
> +	 * without link ID in the status and the device happens to use
> +	 * identical addresses for one of the links and the MLD, then
> +	 * we cannot identify whether it was translated already or not.
>   	 */
> -	link_sta = link_sta_info_get_bss(rx->sdata, hdr->addr2);
> +	if (!status->link_valid)
> +		link_sta = link_sta_info_get_bss(rx->sdata, hdr->addr2);
> +
>   	if (link_sta) {
>   		rx->sta = link_sta->sta;
>   		rx->link_id = link_sta->link_id;
>   	} else {
> -		struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
> -
>   		rx->sta = sta_info_get_bss(rx->sdata, hdr->addr2);
>   		if (rx->sta) {
>   			if (status->link_valid &&
Thanks.
Below patch has said driver should report link id if addr translated.

https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/commit/?h=mld&id=ea9d807b56428d65cf43030cbd7ae5a580077147
wifi: mac80211: add link information in ieee80211_rx_status
In MLO, when the address translation from link to MLD is done
in fw/hw, it is necessary to be able to have some information
on the link on which the frame has been received. Extend the
rx API to include link_id and a valid flag in ieee80211_rx_status.
Also make chanes to mac80211 rx APIs to make use of the reported
link_id after sanity checks.
