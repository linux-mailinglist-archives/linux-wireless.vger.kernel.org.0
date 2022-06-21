Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5947B552D2B
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jun 2022 10:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346852AbiFUIie (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Jun 2022 04:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240499AbiFUIiQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Jun 2022 04:38:16 -0400
X-Greylist: delayed 495 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Jun 2022 01:38:13 PDT
Received: from 8.mo576.mail-out.ovh.net (8.mo576.mail-out.ovh.net [46.105.56.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4E221E03
        for <linux-wireless@vger.kernel.org>; Tue, 21 Jun 2022 01:38:13 -0700 (PDT)
Received: from player734.ha.ovh.net (unknown [10.109.146.213])
        by mo576.mail-out.ovh.net (Postfix) with ESMTP id 7472624B26
        for <linux-wireless@vger.kernel.org>; Tue, 21 Jun 2022 08:29:56 +0000 (UTC)
Received: from galgus.net (86-127-225-236.digimobil.es [86.127.225.236])
        (Authenticated sender: jesus.manzano@galgus.net)
        by player734.ha.ovh.net (Postfix) with ESMTPSA id C18BB2B9FA07E;
        Tue, 21 Jun 2022 08:29:53 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-98R002fb55ccc5-be18-4ab5-a209-e6d81af5d401,
                    6817B7CABC2A8B2B04520B2CCEA7646984C12D8D) smtp.auth=jesus.manzano@galgus.net
X-OVh-ClientIp: 86.127.225.236
Message-ID: <fd68f826-8e38-cbfd-87cc-720a2a3b1530@galgus.net>
Date:   Tue, 21 Jun 2022 10:29:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] ath11k: fix number of VHT beamformee spatial streams
Content-Language: en-US
To:     Sipos Csaba <dchardware@gmail.com>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
References: <20220616173947.21901-1-jesus.manzano@galgus.net>
 <CALQr=E8S6gt_UjaP7GS3M0Tn-MGg7-Xs03Q3suuV7=OP4XmiEQ@mail.gmail.com>
From:   =?UTF-8?Q?Jes=c3=bas_Fern=c3=a1ndez_Manzano?= 
        <jesus.manzano@galgus.net>
In-Reply-To: <CALQr=E8S6gt_UjaP7GS3M0Tn-MGg7-Xs03Q3suuV7=OP4XmiEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 9332584329886363967
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrudeffedgtdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttdefjeenucfhrhhomheplfgvshprshgphfgvrhhnjohnuggviigpofgrnhiirghnohcuoehjvghsuhhsrdhmrghniigrnhhosehgrghlghhushdrnhgvtheqnecuggftrfgrthhtvghrnhepfeeiueeltdfghfegfffgkedtfeefgfduuddvkeekleevieehieelveevfeeghffgnecukfhppedtrddtrddtrddtpdekiedruddvjedrvddvhedrvdefieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrjeefgedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehjvghsuhhsrdhmrghniigrnhhosehgrghlghhushdrnhgvthdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdifihhrvghlvghsshesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheejie
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Csaba,

It happens the same to me, HE is also affected and not fixed by this 
patch because it is treated in a different place in the code than where 
the VHT capabilities are set. If this patch is correct and is accepted I 
would like to fix the HE part and upstream it too.

Ps: thanks for your work in the OpenWRT forum in the Xiaomi AX3600 
thread. Very useful all these months.

Regards,
Jesus

El 20/6/22 a las 19:35, Sipos Csaba escribió:
> Dear Jesus,
>
> I wanted to ask you if you are sure if this is just a VHT issue, and 
> HE is not affected? On my IPQ8074 board with 4 antennas for 5GHz, I 
> have this IW output:
>
>                 HE Iftypes: AP
>                         HE MAC Capabilities (0x000d9a181040):
>                                 +HTC HE Supported
>                                 TWT Responder
>                                 Dynamic BA Fragementation Level: 1
>                                 BSR
>                                 Broadcast TWT
>                                 OM Control
>                                 Maximum A-MPDU Length Exponent: 3
>                                 RX Control Frame to MultiBSS
>                                 A-MSDU in A-MPDU
>                                 OM Control UL MU Data Disable RX
>                         HE PHY Capabilities: (0x1c604c887fdb839c010c00):
>                                 HE40/HE80/5GHz
>                                 HE160/5GHz
>                                 HE160/HE80+80/5GHz
>                                 LDPC Coding in Payload
>                                 HE SU PPDU with 1x HE-LTF and 0.8us GI
>                                 STBC Tx <= 80MHz
>                                 STBC Rx <= 80MHz
>                                 Full Bandwidth UL MU-MIMO
>                                 DCM Max Constellation Rx: 1
>                                 SU Beamformer
>                                 SU Beamformee
>                                 MU Beamformer
>                                 Beamformee STS <= 80Mhz: 7
>                                 Beamformee STS > 80Mhz: 3
>                                 Sounding Dimensions <= 80Mhz: 3
>                                 Sounding Dimensions > 80Mhz: 3
>                                 Ng = 16 SU Feedback
>                                 Ng = 16 MU Feedback
>                                 Codebook Size SU Feedback
>                                 Codebook Size MU Feedback
>                                 PPE Threshold Present
>                                 HE SU PPDU & HE PPDU 4x HE-LTF 0.8us GI
>                                 Max NC: 3
>                                 STBC Rx > 80MHz
>                                 HE ER SU PPDU 4x HE-LTF 0.8us GI
>                                 TX 1024-QAM
>                                 RX 1024-QAM
>                         HE RX MCS and NSS set <= 80 MHz
>                                 1 streams: MCS 0-11
>                                 2 streams: MCS 0-11
>                                 3 streams: MCS 0-11
>                                 4 streams: MCS 0-11
>                                 5 streams: not supported
>                                 6 streams: not supported
>                                 7 streams: not supported
>                                 8 streams: not supported
>                         HE TX MCS and NSS set <= 80 MHz
>                                 1 streams: MCS 0-11
>                                 2 streams: MCS 0-11
>                                 3 streams: MCS 0-11
>                                 4 streams: MCS 0-11
>                                 5 streams: not supported
>                                 6 streams: not supported
>                                 7 streams: not supported
>                                 8 streams: not supported
>                         HE RX MCS and NSS set 160 MHz
>                                 1 streams: MCS 0-11
>                                 2 streams: MCS 0-11
>                                 3 streams: not supported
>                                 4 streams: not supported
>                                 5 streams: not supported
>                                 6 streams: not supported
>                                 7 streams: not supported
>                                 8 streams: not supported
>                         HE TX MCS and NSS set 160 MHz
>                                 1 streams: MCS 0-11
>                                 2 streams: MCS 0-11
>                                 3 streams: not supported
>                                 4 streams: not supported
>                                 5 streams: not supported
>                                 6 streams: not supported
>                                 7 streams: not supported
>                                 8 streams: not supported
>
> As you can see I have Beamformee STS <= 80Mhz: 7 under HE PHY 
> Capabilities, not sure if that is correct.
>
> Using WLAN.HK.2.5.0.1-01208-QCAHKSWPL_SILICONZ-1 firmware.
>
> Thanks for your answer!
>
> Regards,
> Csaba
>
> Jesus Fernandez Manzano <jesus.manzano@galgus.net> ezt írta (időpont: 
> 2022. jún. 16., Cs, 20:21):
>
>     The number of spatial streams used when acting as a beamformee in VHT
>     mode are reported by the firmware as 7 (8 sts - 1) both in IPQ6018 and
>     IPQ8074 which respectively have 2 and 4 sts each. So the firmware
>     should
>     report 1 (2 - 1) and 3 (4 - 1).
>
>     Fix this by checking that the number of VHT beamformee sts reported by
>     the firmware is not greater than the number of receiving antennas - 1.
>     The fix is based on the same approach used in this same function for
>     sanitizing the number of sounding dimensions reported by the firmware.
>
>     Without this change, acting as a beamformee in VHT mode is not working
>     properly.
>
>     Tested-on: IPQ6018 hw1.0 AHB
>     WLAN.HK.2.5.0.1-01208-QCAHKSWPL_SILICONZ-1
>     Tested-on: IPQ8074 hw2.0 AHB
>     WLAN.HK.2.5.0.1-01208-QCAHKSWPL_SILICONZ-1
>
>     Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax
>     devices")
>     Signed-off-by: Jesus Fernandez Manzano <jesus.manzano@galgus.net>
>     ---
>      drivers/net/wireless/ath/ath11k/mac.c | 25 ++++++++++++++++++++-----
>      1 file changed, 20 insertions(+), 5 deletions(-)
>
>     diff --git a/drivers/net/wireless/ath/ath11k/mac.c
>     b/drivers/net/wireless/ath/ath11k/mac.c
>     index 42d2e8cf8125..7109ca4f166d 100644
>     --- a/drivers/net/wireless/ath/ath11k/mac.c
>     +++ b/drivers/net/wireless/ath/ath11k/mac.c
>     @@ -4950,6 +4950,8 @@ static int ath11k_mac_set_txbf_conf(struct
>     ath11k_vif *arvif)
>             if (vht_cap & (IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE)) {
>                     nsts = vht_cap &
>     IEEE80211_VHT_CAP_BEAMFORMEE_STS_MASK;
>                     nsts >>= IEEE80211_VHT_CAP_BEAMFORMEE_STS_SHIFT;
>     +               if (nsts > (ar->num_rx_chains - 1))
>     +                       nsts = ar->num_rx_chains - 1;
>                     value |= SM(nsts, WMI_TXBF_STS_CAP_OFFSET);
>             }
>
>     @@ -4990,7 +4992,7 @@ static int ath11k_mac_set_txbf_conf(struct
>     ath11k_vif *arvif)
>      static void ath11k_set_vht_txbf_cap(struct ath11k *ar, u32 *vht_cap)
>      {
>             bool subfer, subfee;
>     -       int sound_dim = 0;
>     +       int sound_dim = 0, nsts = 0;
>
>             subfer = !!(*vht_cap &
>     (IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE));
>             subfee = !!(*vht_cap &
>     (IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE));
>     @@ -5000,6 +5002,11 @@ static void ath11k_set_vht_txbf_cap(struct
>     ath11k *ar, u32 *vht_cap)
>                     subfer = false;
>             }
>
>     +       if (ar->num_rx_chains < 2) {
>     +               *vht_cap &=
>     ~(IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE);
>     +               subfee = false;
>     +       }
>     +
>             /* If SU Beaformer is not set, then disable MU Beamformer
>     Capability */
>             if (!subfer)
>                     *vht_cap &=
>     ~(IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE);
>     @@ -5012,7 +5019,9 @@ static void ath11k_set_vht_txbf_cap(struct
>     ath11k *ar, u32 *vht_cap)
>             sound_dim >>= IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_SHIFT;
>             *vht_cap &= ~IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_MASK;
>
>     -       /* TODO: Need to check invalid STS and Sound_dim values
>     set by FW? */
>     +       nsts = (*vht_cap & IEEE80211_VHT_CAP_BEAMFORMEE_STS_MASK);
>     +       nsts >>= IEEE80211_VHT_CAP_BEAMFORMEE_STS_SHIFT;
>     +       *vht_cap &= ~IEEE80211_VHT_CAP_BEAMFORMEE_STS_MASK;
>
>             /* Enable Sounding Dimension Field only if SU BF is enabled */
>             if (subfer) {
>     @@ -5024,9 +5033,15 @@ static void ath11k_set_vht_txbf_cap(struct
>     ath11k *ar, u32 *vht_cap)
>                     *vht_cap |= sound_dim;
>             }
>
>     -       /* Use the STS advertised by FW unless SU Beamformee is
>     not supported*/
>     -       if (!subfee)
>     -               *vht_cap &= ~(IEEE80211_VHT_CAP_BEAMFORMEE_STS_MASK);
>     +       /* Enable Beamformee STS Field only if SU BF is enabled */
>     +       if (subfee) {
>     +               if (nsts > (ar->num_rx_chains - 1))
>     +                       nsts = ar->num_rx_chains - 1;
>     +
>     +               nsts <<= IEEE80211_VHT_CAP_BEAMFORMEE_STS_SHIFT;
>     +               nsts &= IEEE80211_VHT_CAP_BEAMFORMEE_STS_MASK;
>     +               *vht_cap |= nsts;
>     +       }
>      }
>
>      static struct ieee80211_sta_vht_cap
>     -- 
>     2.25.1
>

