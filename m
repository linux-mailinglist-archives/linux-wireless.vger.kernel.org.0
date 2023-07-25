Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F500761042
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jul 2023 12:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjGYKHm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jul 2023 06:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjGYKHk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jul 2023 06:07:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A8F10C8
        for <linux-wireless@vger.kernel.org>; Tue, 25 Jul 2023 03:07:38 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P8A2mp028730;
        Tue, 25 Jul 2023 10:07:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=RDfDbKw87yLx/k80q32PxpdZT/X7kI3pp8w55wCgkHI=;
 b=lvTV76MBO7iYKSo2KkNQCloX/foD5MXVgvd0bzA33JzPcmWhaFCPXWN3yv6UMezT2FiT
 y/ct6sUf3us6TMPN/ZCWatU7x9QeAz3Lw5LKQcUj5/1W2TJ1hqXh1913E0sEyg7k9mu8
 F/Az18moHBv7j02FlFyXghOVwkobW+hRG5W9fZ4TGpcaY60tPIjHxbl6ZD/SL14wDayC
 BR2V8pVtpTLWyzr0OMsWztZ4uvl26Mj4JplnvcrHF3GowJdlBijvnqY0cj8TxaUSqOC4
 wULUKvq8kLf/PUYeVsHUs22+9l53TlLcqC6+ILM4jZxTOd7FseH7ieIvJbaNIcVv5a6M Xg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s1pfharqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 10:07:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36PA7YYG031893
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 10:07:35 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 25 Jul
 2023 03:07:33 -0700
Message-ID: <f9f53552-4823-c841-866a-77057bef0b11@quicinc.com>
Date:   Tue, 25 Jul 2023 18:07:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 06/11] wifi: ath12k: prepare EHT peer assoc parameters
Content-Language: en-US
To:     Aloka Dixit <quic_alokad@quicinc.com>,
        <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
CC:     Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
References: <20230602235820.23912-1-quic_alokad@quicinc.com>
 <20230602235820.23912-7-quic_alokad@quicinc.com>
 <f4515520-1d3b-1b07-6ddd-ae269c12a91f@quicinc.com>
 <cdfbb85a-f3be-8cdc-7117-7550d3808a13@quicinc.com>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <cdfbb85a-f3be-8cdc-7117-7550d3808a13@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fyUfHHgujHu0-IkA9OqT3h1Mysk2jAF1
X-Proofpoint-GUID: fyUfHHgujHu0-IkA9OqT3h1Mysk2jAF1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_05,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0
 mlxscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307250086
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/25/2023 2:24 AM, Aloka Dixit wrote:
> On 7/24/2023 3:16 AM, Wen Gong wrote:
>> On 6/3/2023 7:58 AM, Aloka Dixit wrote:
>>> ...
>>> +    default:
>>> +        if (arg->peer_phymode == MODE_11BE_EHT20) {
>>> +            const struct ieee80211_eht_mcs_nss_supp_20mhz_only 
>>> *bw_20 =
>>> + &eht_cap->eht_mcs_nss_supp.only_20mhz;
>>
>> When ath12k used as station mode, it entered here as well as AP mode.
>>
>> But remote is AP device for station mode, then remote AP device do 
>> not have the only_20mhz data(EHT-MCS Map (20 MHz-Only Non-AP STA)).
>>
>
> What issue are you seeing? Please elaborate.
>
> The default case will be entered for both AP and non-AP STA modes for 
> all bandwidths.
>
> If the device is a 20-MHz-only device, it will skip 320, 160 and 
> directly enter the default case where 'if' condition will be true.
>
> If the device is not a 20-MHZ-only device then it will enter the 
> 'else' condition after processing 320 and 160 as applicable.
When I configured AP with 11BE-EHT mode for 20 MHz bandwidth on 5 GHz/6 
GHz band,
and then connect to the AP with ath12k for station mode. Then the 
peer_phymode
is MODE_11BE_EHT20, and then ath12k entered the default in function
ath12k_peer_assoc_h_eht() and use the bw_20 which is assigned with
eht_cap->eht_mcs_nss_supp.only_20mhz.

For station mode of ath12k, the eht_cap->eht_mcs_nss_supp is from the IE 
"Supported
EHT-MCS and NSS Set" in assoc resp of AP in function 
ieee80211_eht_cap_ie_to_sta_eht_cap().
Now it is "EHT-MCS Map (BW <= 80MHz): 0x222222" for the AP(11BE-EHT mode 
for 20 MHz
bandwidth on 6 GHz band) in my test as below IEs.

The field only_20mhz and field _80 are union in struct 
ieee80211_eht_mcs_nss_supp, the
value of field _80 is 0x222222 for this AP, then the value of field 
only_20mhz is like this:
rx_tx_mcs7_max_nss=0x22,
rx_tx_mcs9_max_nss=0x22,
rx_tx_mcs11_max_nss=0x22,
rx_tx_mcs13_max_nss=0.

Then ath12k_mac_set_eht_mcs() will get value 0 fro mcs13 because it used 
the field only_20mhz
passed by ath12k_peer_assoc_h_eht().

ieee80211_eht_cap_ie_to_sta_eht_cap()
{
...
     /* Copy MCS/NSS which depends on the peer capabilities */
     memset(&eht_cap->eht_mcs_nss_supp, 0,
            sizeof(eht_cap->eht_mcs_nss_supp));
     memcpy(&eht_cap->eht_mcs_nss_supp, pos, mcs_nss_size);
...
}

struct ieee80211_eht_mcs_nss_supp {
     union {
         struct ieee80211_eht_mcs_nss_supp_20mhz_only only_20mhz;
         struct {
             struct ieee80211_eht_mcs_nss_supp_bw _80;
             struct ieee80211_eht_mcs_nss_supp_bw _160;
             struct ieee80211_eht_mcs_nss_supp_bw _320;
         } __packed bw;
     } __packed;
} __packed;

struct ieee80211_eht_mcs_nss_supp_20mhz_only {
     u8 rx_tx_mcs7_max_nss;
     u8 rx_tx_mcs9_max_nss;
     u8 rx_tx_mcs11_max_nss;
     u8 rx_tx_mcs13_max_nss;
};

struct ieee80211_eht_mcs_nss_supp_bw {
     u8 rx_tx_mcs9_max_nss;
     u8 rx_tx_mcs11_max_nss;
     u8 rx_tx_mcs13_max_nss;
};


IEs of the AP:
Ext Tag: HE Capabilities (IEEE Std 802.11ax/D3.0)
     Tag Number: Element ID Extension (255)
     Ext Tag length: 29
     Ext Tag Number: HE Capabilities (IEEE Std 802.11ax/D3.0) (35)
     HE MAC Capabilities Information: 0x10401a08010d
     HE Phy Capabilities Information
         .... ...0 = Reserved: 0x0
         0000 000. = Channel Width Set: 0x00
             .... ..0. = 40MHz in 2.4GHz band: Not supported
             .... .0.. = 40 & 80MHz in the 5GHz or 6GHz band: Not 
supported //20 MHz
             .... 0... = 160MHz in the 5GHz or 6GHz band: Not supported
             ...0 .... = 160/80+80MHz in the 5GHz or 6GHz band: Not 
supported
             ..0. .... = 242 tone RUs in the 2.4GHz band: Not supported
             .0.. .... = 242 tone RUs in the 5GHz or 6GHz band: Not 
supported
             0... .... = Reserved: 0x0
         Bits 8 to 23: 0x4063
         Bits 24 to 39: 0x1f88
         Bits 40 to 55: 0x8141
         Bits 56 to 71: 0x111c
         Bits 72 to 87: 0x0008
     Supported HE-MCS and NSS Set
     PPE Thresholds
Ext Tag: HE Operation (IEEE Std 802.11ax/D3.0)
     Tag Number: Element ID Extension (255)
     Ext Tag length: 12
     Ext Tag Number: HE Operation (IEEE Std 802.11ax/D3.0) (36)
     HE Operation Parameters: 0x023ff4
     BSS Color Information: 0x0c
     Basic HE-MCS and NSS Set: 0xfffc
     6GHz Operation Information
         Primary Channel: 37
         6GHz Operation Information Control Field
             .... ..00 = Channel Width: 20 MHz (0) //20 MHz
             .... .0.. = Duplicate Beacon: False
             0000 0... = Reserved: 0x00
         Channel Center Frequency Segment0: 37
         Channel Center Frequency Segment1: 0
         Minimum rate: 1
Ext Tag: EHT Capabilities (IEEE Std 802.11be/D2.0)
     Tag Number: Element ID Extension (255)
     Ext Tag length: 15
     Ext Tag Number: EHT Capabilities (IEEE Std 802.11be/D2.0) (108)
     EHT MAC Capabilities Information: 0x0000
     EHT PHY Capabilities Information
     Supported EHT-MCS and NSS Set
         EHT-MCS Map (BW <= 80MHz): 0x222222
             .... .... .... .... .... 0010 = Rx Max Nss That Supports 
EHT-MCS 0-9: 2
             .... .... .... .... 0010 .... = Tx Max Nss That Supports 
EHT-MCS 0-9: 2
             .... .... .... 0010 .... .... = Rx Max Nss That Supports 
EHT-MCS 10-11: 2
             .... .... 0010 .... .... .... = Tx Max Nss That Supports 
EHT-MCS 10-11: 2
             .... 0010 .... .... .... .... = Rx Max Nss That Supports 
EHT-MCS 12-13: 2
             0010 .... .... .... .... .... = Tx Max Nss That Supports 
EHT-MCS 12-13: 2
     EHT PPE Thresholds: <MISSING>


call stack of ieee80211_eht_cap_ie_to_sta_eht_cap():
RIP: 0010:ieee80211_eht_cap_ie_to_sta_eht_cap+0x5a/0x110 [mac80211]
[86593.088253] RSP: 0018:ffffb5fcc1f8f990 EFLAGS: 00010206
[86593.088254] RAX: 0000000000000000 RBX: ffff8c45c2fd6b70 RCX: 
0000000000000000
[86593.088256] RDX: ffff8c45c2fd710e RSI: ffff8c44cba0a408 RDI: 
ffff8c45c2fd6c30
[86593.088257] RBP: ffffb5fcc1f8f9c8 R08: ffff8c45c2fd7147 R09: 
000000000000000e
[86593.088258] R10: ffff8c44cba0a408 R11: ffff8c45c2fd6bd8 R12: 
ffff8c45cd0989c0
[86593.088259] R13: 0000000000000000 R14: ffff8c45c2fd7147 R15: 
ffff8c45c8198000
[86593.088261] FS:  0000000000000000(0000) GS:ffff8c46d6200000(0000) 
knlGS:0000000000000000
[86593.088262] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[86593.088264] CR2: 0000032d89c60000 CR3: 000000000800a006 CR4: 
00000000001706f0
[86593.088265] Call Trace:
[86593.088267]  <TASK>
[86593.088270]  ieee80211_rx_mgmt_assoc_resp.cold+0xed8/0x1b9b [mac80211]
[86593.088336]  ieee80211_sta_rx_queued_mgmt+0x351/0xdd0 [mac80211]
[86593.088394]  ? newidle_balance+0x252/0x410
[86593.088399]  ? dequeue_entity+0x125/0x400
[86593.088402]  ? preempt_count_add+0x7c/0xc0
[86593.088406]  ? _raw_spin_lock_irqsave+0x28/0x60
[86593.088410]  ieee80211_iface_work+0x30a/0x410 [mac80211]
[86593.088459]  ? __schedule+0x319/0x9b0
[86593.088461]  process_one_work+0x227/0x440
[86593.088465]  worker_thread+0x31/0x3e0
[86593.088467]  ? process_one_work+0x440/0x440
[86593.088469]  kthread+0xfe/0x130
[86593.088471]  ? kthread_complete_and_exit+0x20/0x20
[86593.088473]  ret_from_fork+0x22/0x30
[86593.088479]  </TASK>

>
>> Also 20 MHz should be same for 5 GHz/6 GHz(MODE_11BE_EHT20) and 2.4 
>> GHz(MODE_11BE_EHT20_2G), right?
>>
>
> Good point, I will add a check for MODE_11BE_EHT20_2G as well here.
>
>>> +
>>> + ath12k_mac_set_eht_mcs(bw_20->rx_tx_mcs7_max_nss,
>>> +                           bw_20->rx_tx_mcs9_max_nss,
>>> +                           bw_20->rx_tx_mcs11_max_nss,
>>> +                           bw_20->rx_tx_mcs13_max_nss,
>>> + &rx_mcs[WMI_EHTCAP_TXRX_MCS_NSS_IDX_80],
>>> + &tx_mcs[WMI_EHTCAP_TXRX_MCS_NSS_IDX_80]);
>>> +        } else {
>>> +            bw = &eht_cap->eht_mcs_nss_supp.bw._80;
>>> +            ath12k_mac_set_eht_mcs(bw->rx_tx_mcs9_max_nss,
>>> +                           bw->rx_tx_mcs9_max_nss,
>>> +                           bw->rx_tx_mcs11_max_nss,
>>> +                           bw->rx_tx_mcs13_max_nss,
>>> + &rx_mcs[WMI_EHTCAP_TXRX_MCS_NSS_IDX_80],
>>> + &tx_mcs[WMI_EHTCAP_TXRX_MCS_NSS_IDX_80]);
>>> +        }
>>> +
>>> +        arg->peer_eht_mcs_count++;
>>> +        break;
>>> +    }
>>> +}
>>> +
>>
>> ...
>
