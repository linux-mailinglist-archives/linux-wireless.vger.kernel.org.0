Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80FDE7C0203
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Oct 2023 18:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbjJJQxr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Oct 2023 12:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbjJJQxq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Oct 2023 12:53:46 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36895AC
        for <linux-wireless@vger.kernel.org>; Tue, 10 Oct 2023 09:53:43 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id CB8F69C006B;
        Tue, 10 Oct 2023 16:53:40 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 3F39513C2B0;
        Tue, 10 Oct 2023 09:53:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 3F39513C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1696956819;
        bh=HzIWnJGpgnxRkVixinpk5ab37FhIetoHT/Mz1klgDVw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=E9vJhQtKxdmfTpVp9hJ2JckeTScteOxyHJs7LP6oDhO+KKjSZarNCq1t9eCeB0uam
         dvts1gJc61uES2Siarrotff78WHnm+xcS6yX9725em59B//DQ1DCKR6Dm3W4alaYj5
         15w40xg8iW68/2htyzxiKY50mISNA/uQytQZs70o=
Message-ID: <cc669b2b-06c0-ec93-b9c5-0420ed1e7362@candelatech.com>
Date:   Tue, 10 Oct 2023 09:53:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: wifi-7 + MLO: wlan is not seen in /proc/net/wireless
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <db9ef851-5784-c6a5-d3d5-5747ef21e0b6@candelatech.com>
 <87zg0zgemy.fsf@kernel.org>
 <3e684eea-147b-ca03-1c40-291ece4d1ebb@candelatech.com>
 <2ec54be2691176677386253e64e819deadcf00fb.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <2ec54be2691176677386253e64e819deadcf00fb.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1696956821-2tQTnzvRmv0K
X-MDID-O: us5;at1;1696956821;2tQTnzvRmv0K;<greearb@candelatech.com>;9989741adba0574bb335b9e9d00002fb
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/10/23 07:28, Johannes Berg wrote:
> On Wed, 2023-10-04 at 06:19 -0700, Ben Greear wrote:
>> On 10/3/23 10:06 PM, Kalle Valo wrote:
>>> Ben Greear <greearb@candelatech.com> writes:
>>>
>>>> I'm testing a wifi-7 radio against MLO AP.  I notice the link-0 debugfgs links
>>>> show up and STA is associated and acquired DHCP, but wlan is not in /proc/net/wireless.
>>>> I'm in 6.5.5+ kernel.
>>>>
>>>> Is this expected?
>>>
>>> wext doesn't support Wi-Fi 7, see:
>>>
>>> https://git.kernel.org/linus/52fd90638a72
>>
>> For somewhat similar reasons, ethtool stats are broken for MLO
>> too (see my patches from yesterday).
>>
>> To keep at least some backwards compatibility, would it be worth
>> reporting the 'best' link's information?  To me best is highest
>> band that is connected.  It could also just be the first link that is
>> connected.
> 
> So I think we should differentiate here. For wext, certainly no. I don't
> want to support wext forever, and multi-link is a really good reason to
> say "nope, things just stop working here, stop using 1996 technology".
> 
> For ethtool, well, to be honest I never really liked it in the first
> place (*), but I guess we should somehow fix some things there...
> Perhaps report some cumulative values?

Ok, how about for anything that makes sense as a sum, the current ethtool values will be sum
of all links.  For anything that doesn't make sense as a sum, it will be from link
connected on the highest band.

And as follow on patch(es), add some per-link stats as seems useful.

Does that sound like a good approach?

> 
> But let's discuss that on the individual patches I guess.
> 
> 
> (*) I also don't like your iwlwifi patch for those 'buckets', FWIW,
> there's no real explanation for why the buckets should be this way, and
> putting an array into flat ethtool also feels just wrong.

Ethtool is best option available for driver stats, considering only other thing I am
aware of in this area is parsing debugfs files.

Ethtool API makes it easy to grow arrays or otherwise add stats.  User-space that
is paying attention can map strings to indices and then grab data efficiently
after that.  To make mapping stings to indices work best, it is good if drivers use
the same ethtool strings when possible.  So, I originally coded up the histogram logic
for mt76, and it has specific way of reporting ampdu buckets from its firmware.
To make iwlwifi 'just work' with same ethtool strings mappings, I chose same buckets
as mt76 uses.  If you have a specific reason you would like a different bucket layout,
and if that would make patches acceptable into iwlwifi, then please propose your
preferred layout.  I'd like to get patches upstream, even at cost of me having to do more
user-space hacking to use the new stats.

For reference, with all of my ethtool patches to mnac80211 and iwlwifi, here is stats
dump.  The tx/rx ampdu and mcs histograms give what I think is a pretty good view into
how the wifi is performing in different scenarios.

# ethtool -S wlan0
NIC statistics:
      rx_packets: 1116301
      rx_bytes: 210234100
      rx_duplicates: 0
      rx_fragments: 565617
      rx_dropped: 1
      tx_packets: 1560
      tx_bytes: 103527
      tx_filtered: 0
      tx_retry_failed: 1
      tx_retries: 139
      sta_state: 4
      txrate: 2882300000
      rxrate: 2268500000
      signal: 220
      signal_beacon: 219
      signal_chains: 56278
      signal_chains_avg: 43990
      channel: 6135
      noise: 18446744073709551615
      ch_time: 18446744073709551615
      ch_time_busy: 18446744073709551615
      ch_time_ext_busy: 18446744073709551615
      ch_time_rx: 18446744073709551615
      ch_time_tx: 18446744073709551615
      tx_pkts_nic: 1559
      tx_bytes_nic: 103417
      rx_pkts_nic: 559239
      rx_bytes_nic: 212001488
      tx_mpdu_attempts: 1699
      tx_mpdu_fail: 1
      tx_mpdu_retry: 139
      txo_tx_mpdu_attempts: 0
      txo_tx_mpdu_fail: 0
      txo_tx_mpdu_retry: 0
      txo_tx_mpdu_ok: 0
      tx_direct_done: 0
      tx_postpone_delay: 0
      tx_postpone_few_bytes: 0
      tx_postpone_bt_prio: 0
      tx_postpone_quiet_period: 0
      tx_postpone_calc_ttak: 0
      tx_fail_internal_x_retry: 0
      tx_fail_short_limit: 0
      tx_fail_long_limit: 1
      tx_fail_underrun: 0
      tx_fail_drain_flow: 0
      tx_fail_rfkill_flush: 0
      tx_fail_life_expire: 0
      tx_fail_dest_ps: 0
      tx_fail_host_aborted: 0
      tx_fail_bt_retry: 0
      tx_fail_sta_invalid: 0
      tx_fail_frag_dropped: 0
      tx_fail_tid_disable: 0
      tx_fail_fifo_flushed: 0
      tx_fail_small_cf_poll: 0
      tx_fail_fw_drop: 0
      tx_fail_color_mismatch: 0
      tx_fail_internal_abort: 0
      tx_fail_unknown_oor: 0
      tx_mode_cck: 0
      tx_mode_ofdm: 7
      tx_mode_ht: 0
      tx_mode_vht: 0
      tx_mode_he: 0
      tx_mode_eht: 1553
      tx_mode_he_su: 1553
      tx_mode_he_ext_su: 0
      tx_mode_he_mu: 0
      tx_mode_he_trig: 0
      tx_ampdu_len:0-1: 3120
      tx_ampdu_len:2-10: 0
      tx_ampdu_len:11-19: 0
      tx_ampdu_len:20-28: 0
      tx_ampdu_len:29-37: 0
      tx_ampdu_len:38-46: 0
      tx_ampdu_len:47-55: 0
      tx_ampdu_len:56-79: 0
      tx_ampdu_len:80-103: 0
      tx_ampdu_len:104-127: 0
      tx_ampdu_len:128-151: 0
      tx_ampdu_len:152-175: 0
      tx_ampdu_len:176-199: 0
      tx_ampdu_len:200-223: 0
      tx_ampdu_len:224-247: 0
      tx_bw_20: 7
      tx_bw_40: 0
      tx_bw_80: 0
      tx_bw_160: 1553
      tx_bw_320: 0
      tx_bw_106_tone: 0
      tx_mcs_0: 7
      tx_mcs_1: 0
      tx_mcs_2: 0
      tx_mcs_3: 17
      tx_mcs_4: 20
      tx_mcs_5: 20
      tx_mcs_6: 20
      tx_mcs_7: 20
      tx_mcs_8: 20
      tx_mcs_9: 20
      tx_mcs_10: 20
      tx_mcs_11: 20
      tx_mcs_12: 39
      tx_mcs_13: 1337
      tx_nss_1: 7
      tx_nss_2: 1553
      rx_crc_err: 0
      rx_fifo_underrun: 0
      rx_failed_decrypt: 0
      rx_dup: 1
      rx_bad_header_len: 0
      rx_mode_cck: 108
      rx_mode_ofdm: 558779
      rx_mode_ht: 0
      rx_mode_vht: 0
      rx_mode_he: 0
      rx_mode_eht: 455
      rx_mode_he_su: 160
      rx_mode_he_ext_su: 0
      rx_mode_he_mu: 295
      rx_mode_he_trig: 0
      rx_bw_20: 558887
      rx_bw_40: 0
      rx_bw_80: 0
      rx_bw_160: 455
      rx_bw_320: 0
      rx_bw_he_ru: 0
      rx_mcs_0: 558887
      rx_mcs_1: 0
      rx_mcs_2: 0
      rx_mcs_3: 0
      rx_mcs_4: 0
      rx_mcs_5: 0
      rx_mcs_6: 0
      rx_mcs_7: 0
      rx_mcs_8: 0
      rx_mcs_9: 0
      rx_mcs_10: 0
      rx_mcs_11: 172
      rx_mcs_12: 260
      rx_mcs_13: 23
      rx_ampdu_len:0-1: 454
      rx_ampdu_len:2-10: 0
      rx_ampdu_len:11-19: 0
      rx_ampdu_len:20-28: 0
      rx_ampdu_len:29-37: 0
      rx_ampdu_len:38-46: 0
      rx_ampdu_len:47-55: 0
      rx_ampdu_len:56-79: 0
      rx_ampdu_len:80-103: 0
      rx_ampdu_len:104-127: 0
      rx_ampdu_len:128-151: 0
      rx_ampdu_len:152-175: 0
      rx_ampdu_len:176-199: 0
      rx_ampdu_len:200-223: 0
      rx_ampdu_len:224-247: 0
      rx_nss_1: 558887
      rx_nss_2: 455

Thanks,
Ben


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


