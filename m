Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9384C6E172D
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Apr 2023 00:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjDMWHb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Apr 2023 18:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjDMWH1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Apr 2023 18:07:27 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473D64EFD
        for <linux-wireless@vger.kernel.org>; Thu, 13 Apr 2023 15:07:25 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 3A27678005C;
        Thu, 13 Apr 2023 22:07:22 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 8BBA313C2B1;
        Thu, 13 Apr 2023 15:07:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 8BBA313C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1681423641;
        bh=pFQuFNbgMTH8Xc4H5ZnLj3uaXptQ50O1apupEGyzTyQ=;
        h=Date:Subject:From:To:References:In-Reply-To:From;
        b=ji2mlj+eUDZvpq6EaE7h/2B4QA1LrtJDb+Z/Yf4YMTy96ZeH/tW8VacKqsQRuomVN
         Tf6+5o+F1sl0KbMmdSfdBXQ8bGp/HxvT1jhtRTcw2DuGiLGU69cEME4Ytn/QSs9+v2
         QLoAN4exJZouKyxMr05jvTxRVMJKqm7xKC6X+hUk=
Message-ID: <96cae037-1c88-8d35-8c23-8670c0dff096@candelatech.com>
Date:   Thu, 13 Apr 2023 15:07:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: mtk7922 in 160Mhz AP mode not working properly.
Content-Language: en-US
From:   Ben Greear <greearb@candelatech.com>
To:     =?UTF-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <33d6f55b-399b-0b34-54dc-bdd96846531e@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <33d6f55b-399b-0b34-54dc-bdd96846531e@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1681423643-1aSLeKznhBBe
X-MDID-O: us5;ut7;1681423643;1aSLeKznhBBe;<greearb@candelatech.com>;2c9d590bd07775d3f0179e9dbbd6c2c0
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/13/23 14:47, Ben Greear wrote:
> Hello,
> 
> I did some testing with mtk7922 radios in AP mode today, on 6E band.

Err, I finally looked at the right piece of info after sending this.
7922 iw phy info indicates only 80Mhz supported in AP mode, but 160Mhz
in STA mode.  That would explain why I see strange issues I guess.

Thanks,
Ben

> 
> STA is an mtk7921 radio, and sniffer is also 7921.
> 
> In 80Mhz mode, it seems to work fine, but when I tell AP to go to 160
> Mhz mode, then it seems that AP cannot transmit data frame (properly) to STA.
> mtk7921 STA associates but will not get DHCP.  Sniffing ap interface shows DHCP Discover
> and attempt to send DHCP response.
> 
> Sniffer shows lots of RTS/CTS when AP should be sending DHCP response, but sniffer
> cannot decode any frames.  Possibly AP is transmitting at 160Mhz, even though STA
> should not be advertising that it can do such since 7921 is 80Mhz max.
> 
> An intel ax210 STA radio doesn't even show scan results when AP is in 160 Mode,
> but connects right away when AP is in 80Mhz mode.
> 
>  From what I can tell, the AP's beacon is also missing the sections that indicate it
> can do 160Mhz.  I assume that should not keep it from sending data frames properly.
> And always possible I am screwing up the hostapd config, which is below.
> 
> interface=vap922
> driver=nl80211
> logger_syslog=-1
> logger_syslog_level=2
> logger_stdout=-1
> logger_stdout_level=2
> ctrl_interface=/var/run/hostapd
> ctrl_interface_group=0
> ssid=vap-mtk7922
> bssid=3c:55:76:6d:ae:4f
> country_code=US
> ieee80211d=1
> ieee80211h=1
> ieee80211w=2
> hw_mode=a
> beacon_int=100
> dtim_period=2
> max_num_sta=2007
> rts_threshold=2347
> preamble=0
> macaddr_acl=0
> auth_algs=1
> ignore_broadcast_ssid=0
> # Enable HT modes if you want 300Mbps+ throughput.
> #ht_capab=[HT20][HT40-][HT40+][GF][SHORT-GI-20][SHORT-GI-40]
> #         [TX-STBC][RX-STBC123][MAX-AMSDU-7935][DSSS_CCK-40][PSMP][LSIG-TXOP-PROT]
> #ht_capab=[HT20][HT40+][HT40-][SHORT-GI-40][SHORT-GI-20][LDPC][TX-SDBC][RX-STBC1][DSSS_CCK-40]
> #vht_capab=[MAX-MPDU-11454][RXLDPC][SHORT-GI-80][TX-STBC-2BY1][RX-STBC-1][MAX-A-MPDU-LEN-EXP0][RX-ANTENNA-PATTERN][TX-ANTENNA-PATTERN][SU-BEAMFORMER][SU-BEAMFORMEE][MU-BEAMFORMER][VHT160-80PLUS80][MAX-A-MPDU-LEN-EXP7][BF-ANTENNA-2][SOUNDING-DIMENSION-2][BF-ANTENNA-3][SOUNDING-DIMENSION-3]
> 
> wmm_enabled=1
> wmm_ac_bk_cwmin=4
> wmm_ac_bk_cwmax=10
> wmm_ac_bk_aifs=7
> wmm_ac_bk_txop_limit=0
> wmm_ac_bk_acm=0
> wmm_ac_be_aifs=3
> wmm_ac_be_cwmin=4
> wmm_ac_be_cwmax=10
> wmm_ac_be_txop_limit=0
> wmm_ac_be_acm=0
> wmm_ac_vi_aifs=2
> wmm_ac_vi_cwmin=3
> wmm_ac_vi_cwmax=4
> wmm_ac_vi_txop_limit=94
> wmm_ac_vi_acm=0
> wmm_ac_vo_aifs=2
> wmm_ac_vo_cwmin=2
> wmm_ac_vo_cwmax=3
> wmm_ac_vo_txop_limit=47
> wmm_ac_vo_acm=0
> op_class=134
> 
> ieee80211ax=1
> he_default_pe_duration=4
> he_rts_threshold=1023
> he_oper_chwidth=2
> 
> channel=33
> he_oper_centr_freq_seg0_idx=47
> supported_rates=60 90 120 180 240 360 480 540
> ieee8021x=0
> eapol_key_index_workaround=0
> eap_server=0
> own_ip_addr=127.0.0.1
> wpa_pairwise=TKIP CCMP
> rsn_pairwise=CCMP
> sae_pwe=2
> wpa_passphrase=lanforge
> wpa=2
> wpa_key_mgmt=SAE
> 
> 
> Thanks,
> Ben
> 
> 
> 

