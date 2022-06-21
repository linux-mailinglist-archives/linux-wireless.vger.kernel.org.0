Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A461F5531A4
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jun 2022 14:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350269AbiFUMG5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Jun 2022 08:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbiFUMG4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Jun 2022 08:06:56 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BAA2B25A
        for <linux-wireless@vger.kernel.org>; Tue, 21 Jun 2022 05:06:52 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-101d2e81bceso9269477fac.0
        for <linux-wireless@vger.kernel.org>; Tue, 21 Jun 2022 05:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iK8lZT9kCDyTEHLgZGOEntSp6BkIvky9+NQ2JRkqH8s=;
        b=aHJEDTq7l0BFj2bfZDR1BP0cXXhwzhekxZRXetpQOMjAkwNGDTF4/ZCOkZX3zUJ4ry
         RMSEOo1jJSHJxqUJQyR++mdNxmsV1Krs/AsKyVdbIgqf0DBmbG/hlgYs/R6a3+PU1cbN
         tASdV55CH4eZ94lQJ1g3H5n9VpP34KEDCY8Ze+TIR14j4faUjX6/dIh4uHKfNPJ5aThi
         SiucKqnjZQDpS0RfyHhmuSAwesCyxRmbJ26pW6qCrD0d1FvX4mAnes+sCM9jqvUczQyP
         pC8Qh1PWZ4leESxSF3Jzr+jCLNKJ+6VD06t04gkxX20TFqYJJODiSldXZxCJksThzTq0
         70DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iK8lZT9kCDyTEHLgZGOEntSp6BkIvky9+NQ2JRkqH8s=;
        b=cbBOGmgjEWBn6LXHHuZSIcLFvVG365Eer+P6qix/NMCH68C5E0Tue/O3gxWc5hpTku
         dHWKLsKTreZRmIC9uXmpwros6ZeLhId4B5BIWB7kVFGvvrUmT9DctWiQ5YvFK+w3XNS6
         NYj/Yy7rGiuM/Jl8JVn0NpHpECGoasdk5a9mozM4FiLaWlLU8MJ5eMOP4HXWu4G+6wDM
         BharEjuGmebxFkyw75SWCVzdROp+zoBhZSOgKwuWVx87GRr/QtjK5iJaqXLiRiQJhdiI
         Bl/G+howuuhobdjSFjaBvz7ySxzVes7JQihxHTZb1yr4cCtRFJ1aRJv5xTzmhvVkMHwc
         py+w==
X-Gm-Message-State: AJIora9iuUcXlCrT0ogIRlChrhSUA92gM6C81qMDsR9PahpaQHNFor+B
        fEnLiN8IU+q9iG4334OOet/67CJ7smt3wrSduOk=
X-Google-Smtp-Source: AGRyM1th0vA5s/bUBGoNnsmZ0LLIgzqkF1SJU5QOJeDearSABC+OmXCPBlJlsdtlfCi+KZE7pIT4do82hsvTcOEfTa8=
X-Received: by 2002:a05:6870:5819:b0:101:f651:99a2 with SMTP id
 r25-20020a056870581900b00101f65199a2mr5806897oap.167.1655813210556; Tue, 21
 Jun 2022 05:06:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220616173947.21901-1-jesus.manzano@galgus.net>
 <CALQr=E8S6gt_UjaP7GS3M0Tn-MGg7-Xs03Q3suuV7=OP4XmiEQ@mail.gmail.com> <fd68f826-8e38-cbfd-87cc-720a2a3b1530@galgus.net>
In-Reply-To: <fd68f826-8e38-cbfd-87cc-720a2a3b1530@galgus.net>
From:   Sipos Csaba <dchardware@gmail.com>
Date:   Tue, 21 Jun 2022 14:06:04 +0200
Message-ID: <CALQr=E8BNQB0vG2AXqfuUmbOKKCXZR7MFBxAc72db00QTiVPTw@mail.gmail.com>
Subject: Re: [PATCH] ath11k: fix number of VHT beamformee spatial streams
To:     =?UTF-8?Q?Jes=C3=BAs_Fern=C3=A1ndez_Manzano?= 
        <jesus.manzano@galgus.net>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Jesus,

Oh, I am nobody, the masterminds are clearly Robert and Christian
(Ansuel), I just try to use my radio access network knowledge and
common sense to try and dissect issues like this.

I am not sure if you noticed, that when you do uplink heavy tests on
AX, in the current state uplink power is grossly fluctuating reported
by the driver, while the RF environment is static. I am not sure if
this issue with BF will fix it, but sure it sounds plausible. It is
also unknown how the driver calculates RX power per client: does it
uses some sort of reference signal, or the calculated power depends on
traffic volume?

Regards,
Csaba



Jes=C3=BAs Fern=C3=A1ndez Manzano <jesus.manzano@galgus.net> ezt =C3=ADrta =
(id=C5=91pont:
2022. j=C3=BAn. 21., K, 10:29):
>
> Hi Csaba,
>
> It happens the same to me, HE is also affected and not fixed by this
> patch because it is treated in a different place in the code than where
> the VHT capabilities are set. If this patch is correct and is accepted I
> would like to fix the HE part and upstream it too.
>
> Ps: thanks for your work in the OpenWRT forum in the Xiaomi AX3600
> thread. Very useful all these months.
>
> Regards,
> Jesus
>
> El 20/6/22 a las 19:35, Sipos Csaba escribi=C3=B3:
> > Dear Jesus,
> >
> > I wanted to ask you if you are sure if this is just a VHT issue, and
> > HE is not affected? On my IPQ8074 board with 4 antennas for 5GHz, I
> > have this IW output:
> >
> >                 HE Iftypes: AP
> >                         HE MAC Capabilities (0x000d9a181040):
> >                                 +HTC HE Supported
> >                                 TWT Responder
> >                                 Dynamic BA Fragementation Level: 1
> >                                 BSR
> >                                 Broadcast TWT
> >                                 OM Control
> >                                 Maximum A-MPDU Length Exponent: 3
> >                                 RX Control Frame to MultiBSS
> >                                 A-MSDU in A-MPDU
> >                                 OM Control UL MU Data Disable RX
> >                         HE PHY Capabilities: (0x1c604c887fdb839c010c00)=
:
> >                                 HE40/HE80/5GHz
> >                                 HE160/5GHz
> >                                 HE160/HE80+80/5GHz
> >                                 LDPC Coding in Payload
> >                                 HE SU PPDU with 1x HE-LTF and 0.8us GI
> >                                 STBC Tx <=3D 80MHz
> >                                 STBC Rx <=3D 80MHz
> >                                 Full Bandwidth UL MU-MIMO
> >                                 DCM Max Constellation Rx: 1
> >                                 SU Beamformer
> >                                 SU Beamformee
> >                                 MU Beamformer
> >                                 Beamformee STS <=3D 80Mhz: 7
> >                                 Beamformee STS > 80Mhz: 3
> >                                 Sounding Dimensions <=3D 80Mhz: 3
> >                                 Sounding Dimensions > 80Mhz: 3
> >                                 Ng =3D 16 SU Feedback
> >                                 Ng =3D 16 MU Feedback
> >                                 Codebook Size SU Feedback
> >                                 Codebook Size MU Feedback
> >                                 PPE Threshold Present
> >                                 HE SU PPDU & HE PPDU 4x HE-LTF 0.8us GI
> >                                 Max NC: 3
> >                                 STBC Rx > 80MHz
> >                                 HE ER SU PPDU 4x HE-LTF 0.8us GI
> >                                 TX 1024-QAM
> >                                 RX 1024-QAM
> >                         HE RX MCS and NSS set <=3D 80 MHz
> >                                 1 streams: MCS 0-11
> >                                 2 streams: MCS 0-11
> >                                 3 streams: MCS 0-11
> >                                 4 streams: MCS 0-11
> >                                 5 streams: not supported
> >                                 6 streams: not supported
> >                                 7 streams: not supported
> >                                 8 streams: not supported
> >                         HE TX MCS and NSS set <=3D 80 MHz
> >                                 1 streams: MCS 0-11
> >                                 2 streams: MCS 0-11
> >                                 3 streams: MCS 0-11
> >                                 4 streams: MCS 0-11
> >                                 5 streams: not supported
> >                                 6 streams: not supported
> >                                 7 streams: not supported
> >                                 8 streams: not supported
> >                         HE RX MCS and NSS set 160 MHz
> >                                 1 streams: MCS 0-11
> >                                 2 streams: MCS 0-11
> >                                 3 streams: not supported
> >                                 4 streams: not supported
> >                                 5 streams: not supported
> >                                 6 streams: not supported
> >                                 7 streams: not supported
> >                                 8 streams: not supported
> >                         HE TX MCS and NSS set 160 MHz
> >                                 1 streams: MCS 0-11
> >                                 2 streams: MCS 0-11
> >                                 3 streams: not supported
> >                                 4 streams: not supported
> >                                 5 streams: not supported
> >                                 6 streams: not supported
> >                                 7 streams: not supported
> >                                 8 streams: not supported
> >
> > As you can see I have Beamformee STS <=3D 80Mhz: 7 under HE PHY
> > Capabilities, not sure if that is correct.
> >
> > Using WLAN.HK.2.5.0.1-01208-QCAHKSWPL_SILICONZ-1 firmware.
> >
> > Thanks for your answer!
> >
> > Regards,
> > Csaba
> >
> > Jesus Fernandez Manzano <jesus.manzano@galgus.net> ezt =C3=ADrta (id=C5=
=91pont:
> > 2022. j=C3=BAn. 16., Cs, 20:21):
> >
> >     The number of spatial streams used when acting as a beamformee in V=
HT
> >     mode are reported by the firmware as 7 (8 sts - 1) both in IPQ6018 =
and
> >     IPQ8074 which respectively have 2 and 4 sts each. So the firmware
> >     should
> >     report 1 (2 - 1) and 3 (4 - 1).
> >
> >     Fix this by checking that the number of VHT beamformee sts reported=
 by
> >     the firmware is not greater than the number of receiving antennas -=
 1.
> >     The fix is based on the same approach used in this same function fo=
r
> >     sanitizing the number of sounding dimensions reported by the firmwa=
re.
> >
> >     Without this change, acting as a beamformee in VHT mode is not work=
ing
> >     properly.
> >
> >     Tested-on: IPQ6018 hw1.0 AHB
> >     WLAN.HK.2.5.0.1-01208-QCAHKSWPL_SILICONZ-1
> >     Tested-on: IPQ8074 hw2.0 AHB
> >     WLAN.HK.2.5.0.1-01208-QCAHKSWPL_SILICONZ-1
> >
> >     Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax
> >     devices")
> >     Signed-off-by: Jesus Fernandez Manzano <jesus.manzano@galgus.net>
> >     ---
> >      drivers/net/wireless/ath/ath11k/mac.c | 25 ++++++++++++++++++++---=
--
> >      1 file changed, 20 insertions(+), 5 deletions(-)
> >
> >     diff --git a/drivers/net/wireless/ath/ath11k/mac.c
> >     b/drivers/net/wireless/ath/ath11k/mac.c
> >     index 42d2e8cf8125..7109ca4f166d 100644
> >     --- a/drivers/net/wireless/ath/ath11k/mac.c
> >     +++ b/drivers/net/wireless/ath/ath11k/mac.c
> >     @@ -4950,6 +4950,8 @@ static int ath11k_mac_set_txbf_conf(struct
> >     ath11k_vif *arvif)
> >             if (vht_cap & (IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE)) {
> >                     nsts =3D vht_cap &
> >     IEEE80211_VHT_CAP_BEAMFORMEE_STS_MASK;
> >                     nsts >>=3D IEEE80211_VHT_CAP_BEAMFORMEE_STS_SHIFT;
> >     +               if (nsts > (ar->num_rx_chains - 1))
> >     +                       nsts =3D ar->num_rx_chains - 1;
> >                     value |=3D SM(nsts, WMI_TXBF_STS_CAP_OFFSET);
> >             }
> >
> >     @@ -4990,7 +4992,7 @@ static int ath11k_mac_set_txbf_conf(struct
> >     ath11k_vif *arvif)
> >      static void ath11k_set_vht_txbf_cap(struct ath11k *ar, u32 *vht_ca=
p)
> >      {
> >             bool subfer, subfee;
> >     -       int sound_dim =3D 0;
> >     +       int sound_dim =3D 0, nsts =3D 0;
> >
> >             subfer =3D !!(*vht_cap &
> >     (IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE));
> >             subfee =3D !!(*vht_cap &
> >     (IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE));
> >     @@ -5000,6 +5002,11 @@ static void ath11k_set_vht_txbf_cap(struct
> >     ath11k *ar, u32 *vht_cap)
> >                     subfer =3D false;
> >             }
> >
> >     +       if (ar->num_rx_chains < 2) {
> >     +               *vht_cap &=3D
> >     ~(IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE);
> >     +               subfee =3D false;
> >     +       }
> >     +
> >             /* If SU Beaformer is not set, then disable MU Beamformer
> >     Capability */
> >             if (!subfer)
> >                     *vht_cap &=3D
> >     ~(IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE);
> >     @@ -5012,7 +5019,9 @@ static void ath11k_set_vht_txbf_cap(struct
> >     ath11k *ar, u32 *vht_cap)
> >             sound_dim >>=3D IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_SHIFT=
;
> >             *vht_cap &=3D ~IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_MASK;
> >
> >     -       /* TODO: Need to check invalid STS and Sound_dim values
> >     set by FW? */
> >     +       nsts =3D (*vht_cap & IEEE80211_VHT_CAP_BEAMFORMEE_STS_MASK)=
;
> >     +       nsts >>=3D IEEE80211_VHT_CAP_BEAMFORMEE_STS_SHIFT;
> >     +       *vht_cap &=3D ~IEEE80211_VHT_CAP_BEAMFORMEE_STS_MASK;
> >
> >             /* Enable Sounding Dimension Field only if SU BF is enabled=
 */
> >             if (subfer) {
> >     @@ -5024,9 +5033,15 @@ static void ath11k_set_vht_txbf_cap(struct
> >     ath11k *ar, u32 *vht_cap)
> >                     *vht_cap |=3D sound_dim;
> >             }
> >
> >     -       /* Use the STS advertised by FW unless SU Beamformee is
> >     not supported*/
> >     -       if (!subfee)
> >     -               *vht_cap &=3D ~(IEEE80211_VHT_CAP_BEAMFORMEE_STS_MA=
SK);
> >     +       /* Enable Beamformee STS Field only if SU BF is enabled */
> >     +       if (subfee) {
> >     +               if (nsts > (ar->num_rx_chains - 1))
> >     +                       nsts =3D ar->num_rx_chains - 1;
> >     +
> >     +               nsts <<=3D IEEE80211_VHT_CAP_BEAMFORMEE_STS_SHIFT;
> >     +               nsts &=3D IEEE80211_VHT_CAP_BEAMFORMEE_STS_MASK;
> >     +               *vht_cap |=3D nsts;
> >     +       }
> >      }
> >
> >      static struct ieee80211_sta_vht_cap
> >     --
> >     2.25.1
> >
>
