Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78E02C2057
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2019 14:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbfI3MHR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Sep 2019 08:07:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60075 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727885AbfI3MHR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Sep 2019 08:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569845233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r5jysj4Duit4gQpKh0Il5Awi1G0d9y17y11bpes9VAc=;
        b=MFwRe58QVdshTvzlSBtBS+kNFLpH/cvXk/8ui/dSAL49oE32BIBC5lgSCC9E8XFe4CdmCY
        qCqGtIJ+CsaXahFxTN2Bw+4Ewr2dkJgcXOB4rTJw+jc1lXbKgsdquY8gc6epLdAepITDpk
        83JMxOLzoq//2wUM4JICdmF357W0Z0Q=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-xaX507QVPj28j_iXY6S0aQ-1; Mon, 30 Sep 2019 08:07:11 -0400
Received: by mail-lj1-f199.google.com with SMTP id 205so2964470ljf.13
        for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2019 05:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hJh49fbTscO59E2mXX3hrwqiwBsUZ7UjlSq5rQlXd8U=;
        b=Gcn/wO6JcOmvie+xmgivA5JEuIxjBG31xpM57E2C3Sqe1EJfCmb8B7J+NuR7247udK
         Ed3zaVQJgpR5SuvYsQl5bcJcKc5PgQqJR8HlZvB7p8BPzYwMDkXNPdivUWUHN4oV+kMO
         +F1t8eWH8BMu6HAPMdQWIOCSMtFSwHx9HIiV+xmyKyc9eSlQWpJgmMCAST1xg2r5aje/
         TyhKpDVRtqswT53y2tHWNyqqBaTArudiM9D+kparOZCvviRew3+rcZkLSSf60ysleGOB
         Hez0SVlgevLJtKoRUohTkFrrfa9eD3Q7/4Gqx30ZF3Tt7RkwkiMRw+HjER6E0rPdB98w
         q46Q==
X-Gm-Message-State: APjAAAWLYS9RtWnzBr55Bu6wRUwlHOPx85PQ+GlZQPYGnykdbfsxK28+
        NwENVNIGoW9Qs3Bqp81vhScBO73ZvdmzylxiZrk5JG3bRjPhNyrssv93RsmtYeScmM3S+xxyYOB
        PApd30cpcnxBwOtbL6WMV93XbZXKv/a0mAURwD47MpOI=
X-Received: by 2002:ac2:4853:: with SMTP id 19mr10985745lfy.69.1569845228060;
        Mon, 30 Sep 2019 05:07:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwS5QYacSX2Z1k+atKatZK6QnuAFE+b1Co0L5mxOojJfs+iNkh8sNJnz3R0+npXskGr8rzvw35uUHpW/L5dBJg=
X-Received: by 2002:ac2:4853:: with SMTP id 19mr10985631lfy.69.1569845226175;
 Mon, 30 Sep 2019 05:07:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190628092008.11049-1-luca@coelho.fi> <20190628092008.11049-9-luca@coelho.fi>
In-Reply-To: <20190628092008.11049-9-luca@coelho.fi>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Mon, 30 Sep 2019 14:06:30 +0200
Message-ID: <CAGnkfhyMJo11otYVeJmCaMivkbGfrh76i4MgpCN5CmGwQ_+qLA@mail.gmail.com>
Subject: Re: [PATCH 08/20] iwlwifi: mvm: Add log information about SAR status
To:     Luca Coelho <luca@coelho.fi>,
        Haim Dreyfuss <haim.dreyfuss@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org
X-MC-Unique: xaX507QVPj28j_iXY6S0aQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jun 28, 2019 at 11:20 AM Luca Coelho <luca@coelho.fi> wrote:
>
> From: Haim Dreyfuss <haim.dreyfuss@intel.com>
>
> Inform users when SAR status is changing.
>
> Signed-off-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---
>  drivers/net/wireless/intel/iwlwifi/mvm/fw.c  | 3 +++
>  drivers/net/wireless/intel/iwlwifi/mvm/nvm.c | 9 +++++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wi=
reless/intel/iwlwifi/mvm/fw.c
> index b27be2e3eca2..41a98cf01d0e 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
> @@ -850,6 +850,9 @@ int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm, i=
nt prof_a, int prof_b)
>                         return -ENOENT;
>                 }
>
> +               IWL_DEBUG_INFO(mvm,
> +                              "SAR EWRD: chain %d profile index %d\n",
> +                              i, profs[i]);
>                 IWL_DEBUG_RADIO(mvm, "  Chain[%d]:\n", i);
>                 for (j =3D 0; j < ACPI_SAR_NUM_SUB_BANDS; j++) {
>                         idx =3D (i * ACPI_SAR_NUM_SUB_BANDS) + j;
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c b/drivers/net/w=
ireless/intel/iwlwifi/mvm/nvm.c
> index 7bdbd010ae6b..719f793b3487 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
> @@ -620,6 +620,7 @@ void iwl_mvm_rx_chub_update_mcc(struct iwl_mvm *mvm,
>         enum iwl_mcc_source src;
>         char mcc[3];
>         struct ieee80211_regdomain *regd;
> +       u32 wgds_tbl_idx;
>
>         lockdep_assert_held(&mvm->mutex);
>
> @@ -643,6 +644,14 @@ void iwl_mvm_rx_chub_update_mcc(struct iwl_mvm *mvm,
>         if (IS_ERR_OR_NULL(regd))
>                 return;
>
> +       wgds_tbl_idx =3D iwl_mvm_get_sar_geo_profile(mvm);
> +       if (wgds_tbl_idx < 0)
> +               IWL_DEBUG_INFO(mvm, "SAR WGDS is disabled (%d)\n",
> +                              wgds_tbl_idx);
> +       else
> +               IWL_DEBUG_INFO(mvm, "SAR WGDS: geo profile %d is configur=
ed\n",
> +                              wgds_tbl_idx);
> +
>         regulatory_set_wiphy_regd(mvm->hw->wiphy, regd);
>         kfree(regd);
>  }
> --
> 2.20.1
>

Hi all,

this patch seems to cause a long microcode dump:

[   16.792357] iwlwifi 0000:04:00.0: Applying debug destination EXTERNAL_DR=
AM
[   16.939172] iwlwifi 0000:04:00.0: Applying debug destination EXTERNAL_DR=
AM
[   17.019127] iwlwifi 0000:04:00.0: FW already configured (0) - re-configu=
ring
[   17.053395] iwlwifi 0000:04:00.0: Applying debug destination EXTERNAL_DR=
AM
[   17.200436] iwlwifi 0000:04:00.0: Applying debug destination EXTERNAL_DR=
AM
[   17.280572] iwlwifi 0000:04:00.0: FW already configured (0) - re-configu=
ring
[   20.822983] iwlwifi 0000:04:00.0: Microcode SW error detected.
Restarting 0x82000000.
[   20.823153] iwlwifi 0000:04:00.0: Start IWL Error Log Dump:
[   20.823155] iwlwifi 0000:04:00.0: Status: 0x00000080, count: 6
[   20.823157] iwlwifi 0000:04:00.0: Loaded firmware version: 36.77d01142.0
[   20.823158] iwlwifi 0000:04:00.0: 0x00000038 | BAD_COMMAND
[   20.823160] iwlwifi 0000:04:00.0: 0x000002F0 | trm_hw_status0
[   20.823161] iwlwifi 0000:04:00.0: 0x00000000 | trm_hw_status1
[   20.823162] iwlwifi 0000:04:00.0: 0x00024200 | branchlink2
[   20.823163] iwlwifi 0000:04:00.0: 0x00039872 | interruptlink1
[   20.823164] iwlwifi 0000:04:00.0: 0x00000000 | interruptlink2
[   20.823166] iwlwifi 0000:04:00.0: 0x00330405 | data1
[   20.823167] iwlwifi 0000:04:00.0: 0x00000034 | data2
[   20.823168] iwlwifi 0000:04:00.0: 0x00000034 | data3
[   20.823169] iwlwifi 0000:04:00.0: 0x00099ECD | beacon time
[   20.823170] iwlwifi 0000:04:00.0: 0x003662E5 | tsf low
[   20.823171] iwlwifi 0000:04:00.0: 0x00000000 | tsf hi
[   20.823173] iwlwifi 0000:04:00.0: 0x00000000 | time gp1
[   20.823174] iwlwifi 0000:04:00.0: 0x003662E6 | time gp2
[   20.823175] iwlwifi 0000:04:00.0: 0x00000001 | uCode revision type
[   20.823176] iwlwifi 0000:04:00.0: 0x00000024 | uCode version major
[   20.823177] iwlwifi 0000:04:00.0: 0x77D01142 | uCode version minor
[   20.823178] iwlwifi 0000:04:00.0: 0x00000201 | hw version
[   20.823180] iwlwifi 0000:04:00.0: 0x00489008 | board version
[   20.823181] iwlwifi 0000:04:00.0: 0x00330405 | hcmd
[   20.823182] iwlwifi 0000:04:00.0: 0x00022080 | isr0
[   20.823183] iwlwifi 0000:04:00.0: 0x10800000 | isr1
[   20.823184] iwlwifi 0000:04:00.0: 0x28201802 | isr2
[   20.823185] iwlwifi 0000:04:00.0: 0x00400080 | isr3
[   20.823187] iwlwifi 0000:04:00.0: 0x00000000 | isr4
[   20.823188] iwlwifi 0000:04:00.0: 0x003201C8 | last cmd Id
[   20.823189] iwlwifi 0000:04:00.0: 0x00000000 | wait_event
[   20.823190] iwlwifi 0000:04:00.0: 0x00000080 | l2p_control
[   20.823191] iwlwifi 0000:04:00.0: 0x00000000 | l2p_duration
[   20.823192] iwlwifi 0000:04:00.0: 0x00000000 | l2p_mhvalid
[   20.823193] iwlwifi 0000:04:00.0: 0x00000000 | l2p_addr_match
[   20.823195] iwlwifi 0000:04:00.0: 0x0000008F | lmpm_pmg_sel
[   20.823196] iwlwifi 0000:04:00.0: 0x19071249 | timestamp
[   20.823197] iwlwifi 0000:04:00.0: 0x00005868 | flow_handler
[   20.823358] iwlwifi 0000:04:00.0: Start IWL Error Log Dump:
[   20.823359] iwlwifi 0000:04:00.0: Status: 0x00000080, count: 7
[   20.823361] iwlwifi 0000:04:00.0: 0x00000070 | NMI_INTERRUPT_LMAC_FATAL
[   20.823362] iwlwifi 0000:04:00.0: 0x00000000 | umac branchlink1
[   20.823363] iwlwifi 0000:04:00.0: 0xC0086B38 | umac branchlink2
[   20.823364] iwlwifi 0000:04:00.0: 0xC0083D08 | umac interruptlink1
[   20.823365] iwlwifi 0000:04:00.0: 0xC0083D08 | umac interruptlink2
[   20.823367] iwlwifi 0000:04:00.0: 0x00000800 | umac data1
[   20.823368] iwlwifi 0000:04:00.0: 0xC0083D08 | umac data2
[   20.823369] iwlwifi 0000:04:00.0: 0xDEADBEEF | umac data3
[   20.823370] iwlwifi 0000:04:00.0: 0x00000024 | umac major
[   20.823371] iwlwifi 0000:04:00.0: 0x77D01142 | umac minor
[   20.823372] iwlwifi 0000:04:00.0: 0xC088628C | frame pointer
[   20.823374] iwlwifi 0000:04:00.0: 0xC088628C | stack pointer
[   20.823375] iwlwifi 0000:04:00.0: 0x00330405 | last host cmd
[   20.823376] iwlwifi 0000:04:00.0: 0x00000000 | isr status reg
[   20.823495] iwlwifi 0000:04:00.0: Fseq Registers:
[   20.823500] iwlwifi 0000:04:00.0: 0x81F5E342 | FSEQ_ERROR_CODE
[   20.823549] iwlwifi 0000:04:00.0: 0x120F8254 | FSEQ_TOP_INIT_VERSION
[   20.823598] iwlwifi 0000:04:00.0: 0x54034CA7 | FSEQ_CNVIO_INIT_VERSION
[   20.823647] iwlwifi 0000:04:00.0: 0x0000A056 | FSEQ_OTP_VERSION
[   20.823696] iwlwifi 0000:04:00.0: 0xCCA632D8 | FSEQ_TOP_CONTENT_VERSION
[   20.823745] iwlwifi 0000:04:00.0: 0xFCBC4F8A | FSEQ_ALIVE_TOKEN
[   20.823750] iwlwifi 0000:04:00.0: 0x377E9CF5 | FSEQ_CNVI_ID
[   20.823755] iwlwifi 0000:04:00.0: 0x7673FF81 | FSEQ_CNVR_ID
[   20.823804] iwlwifi 0000:04:00.0: 0x03000000 | CNVI_AUX_MISC_CHIP
[   20.823852] iwlwifi 0000:04:00.0: 0x0BADCAFE | CNVR_AUX_MISC_CHIP
[   20.823860] iwlwifi 0000:04:00.0: 0x0BADCAFE |
CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[   20.823910] iwlwifi 0000:04:00.0: 0x0BADCAFE |
CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[   20.823971] iwlwifi 0000:04:00.0: Collecting data: trigger 2 fired.
[   20.823973] ieee80211 phy0: Hardware restart was requested
[   20.823978] iwlwifi 0000:04:00.0: FW Error notification: type
0x00000000 cmd_id 0x05
[   20.823980] iwlwifi 0000:04:00.0: FW Error notification: seq 0x0033
service 0x00000005
[   20.823981] iwlwifi 0000:04:00.0: FW Error notification: timestamp
0x00000000003662E2
[   20.831748] iwlwifi 0000:04:00.0: iwlwifi transaction failed,
dumping registers
[   20.831750] iwlwifi 0000:04:00.0: iwlwifi device config registers:
[   20.832261] iwlwifi 0000:04:00.0: 00000000: 24f38086 00100406
0280003a 00000000 b3d00004 00000000 00000000 00000000
[   20.832264] iwlwifi 0000:04:00.0: 00000020: 00000000 00000000
00000000 01308086 00000000 000000c8 00000000 000001ff
[   20.832266] iwlwifi 0000:04:00.0: 00000040: 00020010 10008ec0
00190c10 0045e811 10110142 00000000 00000000 00000000
[   20.832268] iwlwifi 0000:04:00.0: 00000060: 00000000 00080812
00000405 00000000 00010001 00000000 00000000 00000000
[   20.832271] iwlwifi 0000:04:00.0: 00000080: 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000
[   20.832272] iwlwifi 0000:04:00.0: 000000a0: 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000
[   20.832275] iwlwifi 0000:04:00.0: 000000c0: 00000000 00000000
c823d001 0d000000 00814005 fee004d8 00000000 00000000
[   20.832277] iwlwifi 0000:04:00.0: 000000e0: 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000
[   20.832279] iwlwifi 0000:04:00.0: 00000100: 14010001 00000000
00000000 00462031 00000000 00002000 00000000 00000000
[   20.832280] iwlwifi 0000:04:00.0: 00000120: 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000
[   20.832282] iwlwifi 0000:04:00.0: 00000140: 14c10003 ffb66999
d4258bff 15410018 10031003 0001001e 00481e1f 40a0000f
[   20.832284] iwlwifi 0000:04:00.0: iwlwifi device memory mapped registers=
:
[   20.832434] iwlwifi 0000:04:00.0: 00000000: 00489008 0000ff40
00000000 00000000 00000000 00000000 00000019 00000000
[   20.832437] iwlwifi 0000:04:00.0: 00000020: 00000000 08040005
00000201 d55555d5 d55555d5 d55555d5 80008040 041f0042
[   20.832488] iwlwifi 0000:04:00.0: iwlwifi device AER capability structur=
e:
[   20.832557] iwlwifi 0000:04:00.0: 00000000: 14010001 00000000
00000000 00462031 00000000 00002000 00000000 00000000
[   20.832559] iwlwifi 0000:04:00.0: 00000020: 00000000 00000000 00000000
[   20.832560] iwlwifi 0000:04:00.0: iwlwifi parent port
(0000:00:1c.2) config registers:
[   20.832650] iwlwifi 0000:00:1c.2: 00000000: a1128086 00100407
060400f1 00810000 00000000 00000000 00040400 200000f0
[   20.832652] iwlwifi 0000:00:1c.2: 00000020: b3d0b3d0 0001fff1
00000000 00000000 00000000 00000040 00000000 000203ff
[   20.832654] iwlwifi 0000:00:1c.2: 00000040: 01428010 00008001
0010000f 03724c13 70110042 0014b200 01400000 00000000
[   20.832655] iwlwifi 0000:00:1c.2: 00000060: 00000000 00000837
00000400 0000000e 00010003 00000000 00000000 00000000
[   20.832657] iwlwifi 0000:00:1c.2: 00000080: 00019005 fee00278
00000000 00000000 0000a00d 222e17aa 00000000 00000000
[   20.832659] iwlwifi 0000:00:1c.2: 000000a0: c8030001 00000000
00000000 00000000 00000000 00000000 00000000 00000000
[   20.832661] iwlwifi 0000:00:1c.2: 000000c0: 00000000 00000000
00000000 00000000 07001001 00001842 8b9e0008 00000000
[   20.832663] iwlwifi 0000:00:1c.2: 000000e0: 00630300 8c548c54
00100016 00000000 00000050 4c000000 08410fb3 03000000
[   20.832665] iwlwifi 0000:00:1c.2: 00000100: 14010001 00000000
00000000 00060011 00000000 00002000 00000000 00000000
[   20.832666] iwlwifi 0000:00:1c.2: 00000120: 00000000 00000000
00000000 00000007 00000000 00000000 00000000 00000000
[   20.832668] iwlwifi 0000:00:1c.2: 00000140: 2001000d 0000000f
0000000d 00000000 00000000 00000000 00000000 00000000
[   20.832670] iwlwifi 0000:00:1c.2: 00000160: 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000
[   20.832671] iwlwifi 0000:00:1c.2: 00000180: 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000
[   20.832673] iwlwifi 0000:00:1c.2: 000001a0: 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000
[   20.832675] iwlwifi 0000:00:1c.2: 000001c0: 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000
[   20.832676] iwlwifi 0000:00:1c.2: 000001e0: 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000
[   20.832677] iwlwifi 0000:00:1c.2: 00000200: 2201001e 00b0281f 40a0280f
[   20.832680] iwlwifi 0000:04:00.0: iwlwifi root port (0000:00:1c.2)
AER cap structure:
[   20.832689] iwlwifi 0000:00:1c.2: 00000000: 14010001 00000000
00000000 00060011 00000000 00002000 00000000 00000000
[   20.832691] iwlwifi 0000:00:1c.2: 00000020: 00000000 00000000
00000000 00000007 00000000 00000000
[   20.832693] iwlwifi 0000:04:00.0: FW error in SYNC CMD GEO_TX_POWER_LIMI=
T
[   20.832695] CPU: 2 PID: 163 Comm: kworker/2:2 Not tainted 5.3.1-matteo #=
81
[   20.832696] Hardware name: LENOVO 20EQS64N1B/20EQS64N1B, BIOS
N1EET84W (1.57 ) 05/09/2019
[   20.832706] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
[   20.832707] Call Trace:
[   20.832713]  dump_stack+0x46/0x60
[   20.832723]  iwl_trans_pcie_send_hcmd+0x505/0x520 [iwlwifi]
[   20.832726]  ? wait_woken+0x70/0x70
[   20.832734]  iwl_trans_send_cmd+0x57/0xb0 [iwlwifi]
[   20.832742]  iwl_mvm_send_cmd+0x23/0x80 [iwlmvm]
[   20.832749]  iwl_mvm_get_sar_geo_profile+0xae/0x130 [iwlmvm]
[   20.832756]  iwl_mvm_rx_chub_update_mcc+0x108/0x1a0 [iwlmvm]
[   20.832762]  iwl_mvm_async_handlers_wk+0xaa/0x140 [iwlmvm]
[   20.832765]  process_one_work+0x1cf/0x370
[   20.832767]  worker_thread+0x4a/0x3c0
[   20.832769]  kthread+0xfb/0x130
[   20.832771]  ? cancel_delayed_work+0x90/0x90
[   20.832772]  ? kthread_create_on_node+0x60/0x60
[   20.832773]  ret_from_fork+0x35/0x40
[   20.832777] iwlwifi 0000:04:00.0: Failed to get geographic profile info =
-5
[   20.832792] ------------[ cut here ]------------
[   20.832813] WARNING: CPU: 2 PID: 163 at
drivers/net/wireless/intel/iwlwifi/mvm/scan.c:1874
iwl_mvm_rx_umac_scan_complete_notif.cold+0xc/0x13 [iwlmvm]
[   20.832814] Modules linked in: xt_MASQUERADE xt_conntrack
ipt_REJECT nf_reject_ipv4 xt_tcpudp tun bridge stp llc iptable_mangle
iptable_nat nf_nat nf_conntrack libcrc32c nf_defrag_ipv4
ip6table_filter ip6_tables iptable_filter ip_tables x_tables rmi_smbus
rmi_core snd_hda_codec_hdmi nls_iso8859_1 vfat fat intel_rapl_msr
iwlmvm snd_hda_codec_realtek snd_hda_codec_generic iTCO_wdt uvcvideo
videobuf2_vmalloc mac80211 snd_hda_intel libarc4 coretemp
videobuf2_memops snd_hda_codec intel_rapl_common videobuf2_v4l2
iosf_mbi snd_hwdep videodev snd_hda_core x86_pkg_temp_thermal snd_seq
intel_powerclamp videobuf2_common snd_seq_device kvm_intel iwlwifi
snd_pcm kvm irqbypass intel_cstate snd_timer rtsx_pci_ms
intel_rapl_perf i2c_i801 memstick psmouse snd efivars soundcore
cfg80211 mei_me mei dm_crypt rtsx_pci_sdmmc mmc_core nouveau hwmon
led_class mxm_wmi drm_kms_helper syscopyarea sysfillrect sysimgblt
fb_sys_fops xhci_pci ttm rtsx_pci xhci_hcd e1000e mfd_core drm agpgart
usbcore usb_common wmi video
[   20.832843]  dm_mod ipv6 nf_defrag_ipv6 autofs4
[   20.832846] CPU: 2 PID: 163 Comm: kworker/2:2 Not tainted 5.3.1-matteo #=
81
[   20.832847] Hardware name: LENOVO 20EQS64N1B/20EQS64N1B, BIOS
N1EET84W (1.57 ) 05/09/2019
[   20.832854] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
[   20.832862] RIP:
0010:iwl_mvm_rx_umac_scan_complete_notif.cold+0xc/0x13 [iwlmvm]
[   20.832863] Code: 48 c7 c7 18 6e aa a0 e8 bc 6f 66 e0 0f 0b 49 8b
47 10 44 8b a0 9c 00 00 00 e9 8b de fe ff 48 c7 c7 18 6e aa a0 e8 9e
6f 66 e0 <0f> 0b e9 d2 e3 fe ff 48 c7 c7 18 6e aa a0 e8 8b 6f 66 e0 0f
0b 41
[   20.832864] RSP: 0000:ffffc900003bfdf0 EFLAGS: 00010246
[   20.832865] RAX: 0000000000000024 RBX: ffff88887e765040 RCX: 00000000000=
00006
[   20.832866] RDX: 0000000000000000 RSI: 0000000000000096 RDI: ffff888883a=
96370
[   20.832867] RBP: ffff88887cef1e58 R08: 0000000000000001 R09: 00000000000=
003e9
[   20.832868] R10: 0000000000016a68 R11: 0000000000000004 R12: ffff88887ce=
f1e28
[   20.832868] R13: ffff88887cef1e28 R14: ffff88887c666fc0 R15: dead0000000=
00100
[   20.832870] FS:  0000000000000000(0000) GS:ffff888883a80000(0000)
knlGS:0000000000000000
[   20.832870] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   20.832871] CR2: 00007fced42b4078 CR3: 000000087938a004 CR4: 00000000003=
606e0
[   20.832872] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[   20.832873] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[   20.832873] Call Trace:
[   20.832880]  iwl_mvm_async_handlers_wk+0xaa/0x140 [iwlmvm]
[   20.832883]  process_one_work+0x1cf/0x370
[   20.832885]  worker_thread+0x4a/0x3c0
[   20.832886]  kthread+0xfb/0x130
[   20.832887]  ? cancel_delayed_work+0x90/0x90
[   20.832889]  ? kthread_create_on_node+0x60/0x60
[   20.832890]  ret_from_fork+0x35/0x40
[   20.832891] ---[ end trace c1c6ffcd88e853ba ]---
[   22.960642] iwlwifi 0000:04:00.0: Applying debug destination EXTERNAL_DR=
AM
[   23.108376] iwlwifi 0000:04:00.0: Applying debug destination EXTERNAL_DR=
AM
[   23.188882] iwlwifi 0000:04:00.0: FW already configured (0) - re-configu=
ring
[   26.542158] iwlwifi 0000:04:00.0: Microcode SW error detected.
Restarting 0x82000000.
[   26.542382] iwlwifi 0000:04:00.0: Start IWL Error Log Dump:
[   26.542384] iwlwifi 0000:04:00.0: Status: 0x00000080, count: 6
[   26.542385] iwlwifi 0000:04:00.0: Loaded firmware version: 36.77d01142.0
[   26.542386] iwlwifi 0000:04:00.0: 0x00000038 | BAD_COMMAND
[   26.542387] iwlwifi 0000:04:00.0: 0x000002F0 | trm_hw_status0
[   26.542389] iwlwifi 0000:04:00.0: 0x00000000 | trm_hw_status1
[   26.542390] iwlwifi 0000:04:00.0: 0x00024200 | branchlink2
[   26.542391] iwlwifi 0000:04:00.0: 0x00039872 | interruptlink1
[   26.542392] iwlwifi 0000:04:00.0: 0x00000000 | interruptlink2
[   26.542393] iwlwifi 0000:04:00.0: 0x003B0405 | data1
[   26.542394] iwlwifi 0000:04:00.0: 0x0000003C | data2
[   26.542395] iwlwifi 0000:04:00.0: 0x0000003C | data3
[   26.542396] iwlwifi 0000:04:00.0: 0x000C80BE | beacon time
[   26.542397] iwlwifi 0000:04:00.0: 0x0033801A | tsf low
[   26.542398] iwlwifi 0000:04:00.0: 0x00000000 | tsf hi
[   26.542399] iwlwifi 0000:04:00.0: 0x00000000 | time gp1
[   26.542400] iwlwifi 0000:04:00.0: 0x0033801B | time gp2
[   26.542401] iwlwifi 0000:04:00.0: 0x00000001 | uCode revision type
[   26.542402] iwlwifi 0000:04:00.0: 0x00000024 | uCode version major
[   26.542403] iwlwifi 0000:04:00.0: 0x77D01142 | uCode version minor
[   26.542404] iwlwifi 0000:04:00.0: 0x00000201 | hw version
[   26.542405] iwlwifi 0000:04:00.0: 0x00489008 | board version
[   26.542406] iwlwifi 0000:04:00.0: 0x003B0405 | hcmd
[   26.542407] iwlwifi 0000:04:00.0: 0x00022080 | isr0
[   26.542408] iwlwifi 0000:04:00.0: 0x00000000 | isr1
[   26.542409] iwlwifi 0000:04:00.0: 0x28201802 | isr2
[   26.542410] iwlwifi 0000:04:00.0: 0x00400080 | isr3
[   26.542411] iwlwifi 0000:04:00.0: 0x00000000 | isr4
[   26.542412] iwlwifi 0000:04:00.0: 0x003A01C8 | last cmd Id
[   26.542413] iwlwifi 0000:04:00.0: 0x00000000 | wait_event
[   26.542414] iwlwifi 0000:04:00.0: 0x00000080 | l2p_control
[   26.542415] iwlwifi 0000:04:00.0: 0x00000000 | l2p_duration
[   26.542416] iwlwifi 0000:04:00.0: 0x00000000 | l2p_mhvalid
[   26.542417] iwlwifi 0000:04:00.0: 0x00000000 | l2p_addr_match
[   26.542418] iwlwifi 0000:04:00.0: 0x0000008F | lmpm_pmg_sel
[   26.542419] iwlwifi 0000:04:00.0: 0x19071249 | timestamp
[   26.542420] iwlwifi 0000:04:00.0: 0x00005060 | flow_handler
[   26.542581] iwlwifi 0000:04:00.0: Start IWL Error Log Dump:
[   26.542582] iwlwifi 0000:04:00.0: Status: 0x00000080, count: 7
[   26.542584] iwlwifi 0000:04:00.0: 0x00000070 | NMI_INTERRUPT_LMAC_FATAL
[   26.542585] iwlwifi 0000:04:00.0: 0x00000000 | umac branchlink1
[   26.542586] iwlwifi 0000:04:00.0: 0xC0086B38 | umac branchlink2
[   26.542587] iwlwifi 0000:04:00.0: 0xC0083D08 | umac interruptlink1
[   26.542588] iwlwifi 0000:04:00.0: 0xC0083D08 | umac interruptlink2
[   26.542589] iwlwifi 0000:04:00.0: 0x00000800 | umac data1
[   26.542590] iwlwifi 0000:04:00.0: 0xC0083D08 | umac data2
[   26.542591] iwlwifi 0000:04:00.0: 0xDEADBEEF | umac data3
[   26.542592] iwlwifi 0000:04:00.0: 0x00000024 | umac major
[   26.542593] iwlwifi 0000:04:00.0: 0x77D01142 | umac minor
[   26.542594] iwlwifi 0000:04:00.0: 0xC088628C | frame pointer
[   26.542595] iwlwifi 0000:04:00.0: 0xC088628C | stack pointer
[   26.542596] iwlwifi 0000:04:00.0: 0x003B0405 | last host cmd
[   26.542597] iwlwifi 0000:04:00.0: 0x00000000 | isr status reg
[   26.542716] iwlwifi 0000:04:00.0: Fseq Registers:
[   26.542721] iwlwifi 0000:04:00.0: 0x81F5E342 | FSEQ_ERROR_CODE
[   26.542726] iwlwifi 0000:04:00.0: 0x120F8254 | FSEQ_TOP_INIT_VERSION
[   26.542730] iwlwifi 0000:04:00.0: 0x54034CA7 | FSEQ_CNVIO_INIT_VERSION
[   26.542735] iwlwifi 0000:04:00.0: 0x0000A056 | FSEQ_OTP_VERSION
[   26.542740] iwlwifi 0000:04:00.0: 0xCCA632D8 | FSEQ_TOP_CONTENT_VERSION
[   26.542745] iwlwifi 0000:04:00.0: 0xFCBC4F8A | FSEQ_ALIVE_TOKEN
[   26.542750] iwlwifi 0000:04:00.0: 0x377E9CF5 | FSEQ_CNVI_ID
[   26.542754] iwlwifi 0000:04:00.0: 0x7673FF81 | FSEQ_CNVR_ID
[   26.542759] iwlwifi 0000:04:00.0: 0x03000000 | CNVI_AUX_MISC_CHIP
[   26.542767] iwlwifi 0000:04:00.0: 0x0BADCAFE | CNVR_AUX_MISC_CHIP
[   26.542775] iwlwifi 0000:04:00.0: 0x0BADCAFE |
CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[   26.542782] iwlwifi 0000:04:00.0: 0x0BADCAFE |
CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[   26.542789] iwlwifi 0000:04:00.0: Collecting data: trigger 2 fired.
[   26.542792] ieee80211 phy0: Hardware restart was requested
[   26.542797] iwlwifi 0000:04:00.0: FW Error notification: type
0x00000000 cmd_id 0x05
[   26.542798] iwlwifi 0000:04:00.0: FW Error notification: seq 0x003B
service 0x00000005
[   26.542799] iwlwifi 0000:04:00.0: FW Error notification: timestamp
0x0000000000338017
[   26.542809] iwlwifi 0000:04:00.0: FW error in SYNC CMD GEO_TX_POWER_LIMI=
T
[   26.542812] CPU: 2 PID: 452 Comm: kworker/2:3 Tainted: G        W
      5.3.1-matteo #81
[   26.542813] Hardware name: LENOVO 20EQS64N1B/20EQS64N1B, BIOS
N1EET84W (1.57 ) 05/09/2019
[   26.542823] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
[   26.542825] Call Trace:
[   26.542831]  dump_stack+0x46/0x60
[   26.542841]  iwl_trans_pcie_send_hcmd+0x505/0x520 [iwlwifi]
[   26.542845]  ? wait_woken+0x70/0x70
[   26.542853]  iwl_trans_send_cmd+0x57/0xb0 [iwlwifi]
[   26.542862]  iwl_mvm_send_cmd+0x23/0x80 [iwlmvm]
[   26.542868]  iwl_mvm_get_sar_geo_profile+0xae/0x130 [iwlmvm]
[   26.542876]  iwl_mvm_rx_chub_update_mcc+0x108/0x1a0 [iwlmvm]
[   26.542882]  iwl_mvm_async_handlers_wk+0xaa/0x140 [iwlmvm]
[   26.542885]  process_one_work+0x1cf/0x370
[   26.542887]  worker_thread+0x4a/0x3c0
[   26.542889]  kthread+0xfb/0x130
[   26.542890]  ? cancel_delayed_work+0x90/0x90
[   26.542892]  ? kthread_create_on_node+0x60/0x60
[   26.542893]  ret_from_fork+0x35/0x40
[   26.542896] iwlwifi 0000:04:00.0: Failed to get geographic profile info =
-5
[   26.542901] ------------[ cut here ]------------
[   26.542925] WARNING: CPU: 2 PID: 452 at
drivers/net/wireless/intel/iwlwifi/mvm/scan.c:1874
iwl_mvm_rx_umac_scan_complete_notif.cold+0xc/0x13 [iwlmvm]
[   26.542925] Modules linked in: xt_MASQUERADE xt_conntrack
ipt_REJECT nf_reject_ipv4 xt_tcpudp tun bridge stp llc iptable_mangle
iptable_nat nf_nat nf_conntrack libcrc32c nf_defrag_ipv4
ip6table_filter ip6_tables iptable_filter ip_tables x_tables rmi_smbus
rmi_core snd_hda_codec_hdmi nls_iso8859_1 vfat fat intel_rapl_msr
iwlmvm snd_hda_codec_realtek snd_hda_codec_generic iTCO_wdt uvcvideo
videobuf2_vmalloc mac80211 snd_hda_intel libarc4 coretemp
videobuf2_memops snd_hda_codec intel_rapl_common videobuf2_v4l2
iosf_mbi snd_hwdep videodev snd_hda_core x86_pkg_temp_thermal snd_seq
intel_powerclamp videobuf2_common snd_seq_device kvm_intel iwlwifi
snd_pcm kvm irqbypass intel_cstate snd_timer rtsx_pci_ms
intel_rapl_perf i2c_i801 memstick psmouse snd efivars soundcore
cfg80211 mei_me mei dm_crypt rtsx_pci_sdmmc mmc_core nouveau hwmon
led_class mxm_wmi drm_kms_helper syscopyarea sysfillrect sysimgblt
fb_sys_fops xhci_pci ttm rtsx_pci xhci_hcd e1000e mfd_core drm agpgart
usbcore usb_common wmi video
[   26.542952]  dm_mod ipv6 nf_defrag_ipv6 autofs4
[   26.542956] CPU: 2 PID: 452 Comm: kworker/2:3 Tainted: G        W
      5.3.1-matteo #81
[   26.542956] Hardware name: LENOVO 20EQS64N1B/20EQS64N1B, BIOS
N1EET84W (1.57 ) 05/09/2019
[   26.542963] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
[   26.542972] RIP:
0010:iwl_mvm_rx_umac_scan_complete_notif.cold+0xc/0x13 [iwlmvm]
[   26.542974] Code: 48 c7 c7 18 6e aa a0 e8 bc 6f 66 e0 0f 0b 49 8b
47 10 44 8b a0 9c 00 00 00 e9 8b de fe ff 48 c7 c7 18 6e aa a0 e8 9e
6f 66 e0 <0f> 0b e9 d2 e3 fe ff 48 c7 c7 18 6e aa a0 e8 8b 6f 66 e0 0f
0b 41
[   26.542975] RSP: 0018:ffffc90000517df0 EFLAGS: 00010246
[   26.542976] RAX: 0000000000000024 RBX: ffff888840a3e000 RCX: 00000000000=
00006
[   26.542977] RDX: 0000000000000000 RSI: 0000000000000096 RDI: ffff888883a=
96370
[   26.542978] RBP: ffff88887cef1e58 R08: 0000000000000001 R09: 00000000000=
00465
[   26.542978] R10: 0000000000019a70 R11: 0000000000000004 R12: ffff88887ce=
f1e28
[   26.542979] R13: ffff88887cef1e28 R14: ffff88887addc400 R15: dead0000000=
00100
[   26.542980] FS:  0000000000000000(0000) GS:ffff888883a80000(0000)
knlGS:0000000000000000
[   26.542981] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   26.542982] CR2: 000055ea725e9498 CR3: 0000000001e0a004 CR4: 00000000003=
606e0
[   26.542983] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[   26.542983] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[   26.542984] Call Trace:
[   26.542991]  iwl_mvm_async_handlers_wk+0xaa/0x140 [iwlmvm]
[   26.542994]  process_one_work+0x1cf/0x370
[   26.542996]  worker_thread+0x225/0x3c0
[   26.542997]  kthread+0xfb/0x130
[   26.542999]  ? cancel_delayed_work+0x90/0x90
[   26.543000]  ? kthread_create_on_node+0x60/0x60
[   26.543001]  ret_from_fork+0x35/0x40
[   26.543003] ---[ end trace c1c6ffcd88e853bb ]---
[   27.912222] iwlwifi 0000:04:00.0: Applying debug destination EXTERNAL_DR=
AM
[   28.061048] iwlwifi 0000:04:00.0: Applying debug destination EXTERNAL_DR=
AM
[   28.157251] iwlwifi 0000:04:00.0: FW already configured (0) - re-configu=
ring
[   28.212885] wlp4s0: authenticate with fc:d4:f2:11:2b:ba
[   28.216247] wlp4s0: send auth to fc:d4:f2:11:2b:ba (try 1/3)
[   28.253162] wlp4s0: authenticated
[   28.255847] wlp4s0: associate with fc:d4:f2:11:2b:ba (try 1/3)
[   28.359782] wlp4s0: associate with fc:d4:f2:11:2b:ba (try 2/3)
[   28.380570] wlp4s0: RX AssocResp from fc:d4:f2:11:2b:ba (capab=3D0x11
status=3D0 aid=3D2)
[   28.391573] wlp4s0: associated
[   29.607287] IPv6: ADDRCONF(NETDEV_CHANGE): wlp4s0: link becomes ready
[   38.051771] iwlwifi 0000:04:00.0: regular scan timed out
[   38.051840] iwlwifi 0000:04:00.0: Microcode SW error detected.
Restarting 0x2000000.
[   38.051969] iwlwifi 0000:04:00.0: Start IWL Error Log Dump:
[   38.051971] iwlwifi 0000:04:00.0: Status: 0x00000080, count: 6
[   38.051973] iwlwifi 0000:04:00.0: Loaded firmware version: 36.77d01142.0
[   38.051974] iwlwifi 0000:04:00.0: 0x00000084 | NMI_INTERRUPT_UNKNOWN
[   38.051976] iwlwifi 0000:04:00.0: 0x00000220 | trm_hw_status0
[   38.051977] iwlwifi 0000:04:00.0: 0x00000000 | trm_hw_status1
[   38.051978] iwlwifi 0000:04:00.0: 0x00024200 | branchlink2
[   38.051979] iwlwifi 0000:04:00.0: 0x00039872 | interruptlink1
[   38.051980] iwlwifi 0000:04:00.0: 0x00039872 | interruptlink2
[   38.051981] iwlwifi 0000:04:00.0: 0x00000000 | data1
[   38.051983] iwlwifi 0000:04:00.0: 0x00000080 | data2
[   38.051984] iwlwifi 0000:04:00.0: 0x07830000 | data3
[   38.051985] iwlwifi 0000:04:00.0: 0x17C17E6D | beacon time
[   38.051986] iwlwifi 0000:04:00.0: 0x6DA50196 | tsf low
[   38.051987] iwlwifi 0000:04:00.0: 0x00000016 | tsf hi
[   38.051989] iwlwifi 0000:04:00.0: 0x00000000 | time gp1
[   38.051990] iwlwifi 0000:04:00.0: 0x00978B64 | time gp2
[   38.051991] iwlwifi 0000:04:00.0: 0x00000001 | uCode revision type
[   38.051992] iwlwifi 0000:04:00.0: 0x00000024 | uCode version major
[   38.051993] iwlwifi 0000:04:00.0: 0x77D01142 | uCode version minor
[   38.051994] iwlwifi 0000:04:00.0: 0x00000201 | hw version
[   38.051996] iwlwifi 0000:04:00.0: 0x00489008 | board version
[   38.051997] iwlwifi 0000:04:00.0: 0x0A0D001C | hcmd
[   38.051998] iwlwifi 0000:04:00.0: 0x24022000 | isr0
[   38.051999] iwlwifi 0000:04:00.0: 0x00800000 | isr1
[   38.052000] iwlwifi 0000:04:00.0: 0x08001802 | isr2
[   38.052001] iwlwifi 0000:04:00.0: 0x00417CC0 | isr3
[   38.052002] iwlwifi 0000:04:00.0: 0x00000000 | isr4
[   38.052004] iwlwifi 0000:04:00.0: 0x0A0D001C | last cmd Id
[   38.052005] iwlwifi 0000:04:00.0: 0x00000000 | wait_event
[   38.052006] iwlwifi 0000:04:00.0: 0x000000D4 | l2p_control
[   38.052007] iwlwifi 0000:04:00.0: 0x00018030 | l2p_duration
[   38.052008] iwlwifi 0000:04:00.0: 0x00000007 | l2p_mhvalid
[   38.052010] iwlwifi 0000:04:00.0: 0x00000081 | l2p_addr_match
[   38.052011] iwlwifi 0000:04:00.0: 0x0000000D | lmpm_pmg_sel
[   38.052012] iwlwifi 0000:04:00.0: 0x19071249 | timestamp
[   38.052013] iwlwifi 0000:04:00.0: 0x00340818 | flow_handler
[   38.052082] iwlwifi 0000:04:00.0: 0x00000000 | ADVANCED_SYSASSERT
[   38.052084] iwlwifi 0000:04:00.0: 0x00000000 | umac branchlink1
[   38.052085] iwlwifi 0000:04:00.0: 0x00000000 | umac branchlink2
[   38.052086] iwlwifi 0000:04:00.0: 0x00000000 | umac interruptlink1
[   38.052087] iwlwifi 0000:04:00.0: 0x00000000 | umac interruptlink2
[   38.052088] iwlwifi 0000:04:00.0: 0x00000000 | umac data1
[   38.052090] iwlwifi 0000:04:00.0: 0x00000000 | umac data2
[   38.052091] iwlwifi 0000:04:00.0: 0x00000000 | umac data3
[   38.052092] iwlwifi 0000:04:00.0: 0x00000000 | umac major
[   38.052093] iwlwifi 0000:04:00.0: 0x00000000 | umac minor
[   38.052094] iwlwifi 0000:04:00.0: 0x00000000 | frame pointer
[   38.052095] iwlwifi 0000:04:00.0: 0x00000000 | stack pointer
[   38.052096] iwlwifi 0000:04:00.0: 0x00000000 | last host cmd
[   38.052097] iwlwifi 0000:04:00.0: 0x00000000 | isr status reg
[   38.052117] iwlwifi 0000:04:00.0: Fseq Registers:
[   38.052129] iwlwifi 0000:04:00.0: 0x81F5E342 | FSEQ_ERROR_CODE
[   38.052143] iwlwifi 0000:04:00.0: 0x120F8254 | FSEQ_TOP_INIT_VERSION
[   38.052148] iwlwifi 0000:04:00.0: 0x54034CA7 | FSEQ_CNVIO_INIT_VERSION
[   38.052152] iwlwifi 0000:04:00.0: 0x0000A056 | FSEQ_OTP_VERSION
[   38.052157] iwlwifi 0000:04:00.0: 0xCCA632D8 | FSEQ_TOP_CONTENT_VERSION
[   38.052162] iwlwifi 0000:04:00.0: 0xFCBC4F8A | FSEQ_ALIVE_TOKEN
[   38.052166] iwlwifi 0000:04:00.0: 0x377E9CF5 | FSEQ_CNVI_ID
[   38.052171] iwlwifi 0000:04:00.0: 0x7673FF81 | FSEQ_CNVR_ID
[   38.052181] iwlwifi 0000:04:00.0: 0x03000000 | CNVI_AUX_MISC_CHIP
[   38.052191] iwlwifi 0000:04:00.0: 0x0BADCAFE | CNVR_AUX_MISC_CHIP
[   38.052201] iwlwifi 0000:04:00.0: 0x0BADCAFE |
CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[   38.052211] iwlwifi 0000:04:00.0: 0x0BADCAFE |
CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[   38.052222] iwlwifi 0000:04:00.0: Collecting data: trigger 2 fired.
[   38.052225] ieee80211 phy0: Hardware restart was requested
[   38.615192] iwlwifi 0000:04:00.0: Applying debug destination EXTERNAL_DR=
AM
[   38.768828] iwlwifi 0000:04:00.0: Applying debug destination EXTERNAL_DR=
AM
[   38.851065] iwlwifi 0000:04:00.0: FW already configured (0) - re-configu=
ring
[   70.012833] wlp4s0: Connection to AP fc:d4:f2:11:2b:ba lost
[   70.124167] iwlwifi 0000:04:00.0: offset 0 not used in fw key table.
[   70.124174] wlp4s0: failed to remove key (5, ff:ff:ff:ff:ff:ff)
from hardware (-2)
[   73.377475] iwlwifi 0000:04:00.0: Microcode SW error detected.
Restarting 0x92000000.
[   73.377693] iwlwifi 0000:04:00.0: Start IWL Error Log Dump:
[   73.377698] iwlwifi 0000:04:00.0: Status: 0x00000080, count: 6
[   73.377701] iwlwifi 0000:04:00.0: Loaded firmware version: 36.77d01142.0
[   73.377705] iwlwifi 0000:04:00.0: 0x00000038 | BAD_COMMAND
[   73.377708] iwlwifi 0000:04:00.0: 0x000002F0 | trm_hw_status0
[   73.377711] iwlwifi 0000:04:00.0: 0x00000000 | trm_hw_status1
[   73.377714] iwlwifi 0000:04:00.0: 0x00024200 | branchlink2
[   73.377717] iwlwifi 0000:04:00.0: 0x00039872 | interruptlink1
[   73.377719] iwlwifi 0000:04:00.0: 0x00000000 | interruptlink2
[   73.377722] iwlwifi 0000:04:00.0: 0x00F00405 | data1
[   73.377725] iwlwifi 0000:04:00.0: 0x000000F1 | data2
[   73.377727] iwlwifi 0000:04:00.0: 0x000000F1 | data3
[   73.377730] iwlwifi 0000:04:00.0: 0x544188FA | beacon time
[   73.377733] iwlwifi 0000:04:00.0: 0x6FC00709 | tsf low
[   73.377735] iwlwifi 0000:04:00.0: 0x00000016 | tsf hi
[   73.377738] iwlwifi 0000:04:00.0: 0x00000000 | time gp1
[   73.377741] iwlwifi 0000:04:00.0: 0x020F2BF2 | time gp2
[   73.377744] iwlwifi 0000:04:00.0: 0x00000001 | uCode revision type
[   73.377747] iwlwifi 0000:04:00.0: 0x00000024 | uCode version major
[   73.377749] iwlwifi 0000:04:00.0: 0x77D01142 | uCode version minor
[   73.377752] iwlwifi 0000:04:00.0: 0x00000201 | hw version
[   73.377754] iwlwifi 0000:04:00.0: 0x00489008 | board version
[   73.377757] iwlwifi 0000:04:00.0: 0x00F00405 | hcmd
[   73.377760] iwlwifi 0000:04:00.0: 0x00022080 | isr0
[   73.377762] iwlwifi 0000:04:00.0: 0x10800000 | isr1
[   73.377765] iwlwifi 0000:04:00.0: 0x28201802 | isr2
[   73.377767] iwlwifi 0000:04:00.0: 0x00400080 | isr3
[   73.377770] iwlwifi 0000:04:00.0: 0x00000000 | isr4
[   73.377773] iwlwifi 0000:04:00.0: 0x00EF01C8 | last cmd Id
[   73.377775] iwlwifi 0000:04:00.0: 0x00000000 | wait_event
[   73.377778] iwlwifi 0000:04:00.0: 0x00000BFF | l2p_control
[   73.377781] iwlwifi 0000:04:00.0: 0x00000000 | l2p_duration
[   73.377783] iwlwifi 0000:04:00.0: 0x00000000 | l2p_mhvalid
[   73.377786] iwlwifi 0000:04:00.0: 0x00000000 | l2p_addr_match
[   73.377789] iwlwifi 0000:04:00.0: 0x0000008F | lmpm_pmg_sel
[   73.377791] iwlwifi 0000:04:00.0: 0x19071249 | timestamp
[   73.377794] iwlwifi 0000:04:00.0: 0x0000F000 | flow_handler
[   73.377968] iwlwifi 0000:04:00.0: Start IWL Error Log Dump:
[   73.377971] iwlwifi 0000:04:00.0: Status: 0x00000080, count: 7
[   73.377975] iwlwifi 0000:04:00.0: 0x00000070 | NMI_INTERRUPT_LMAC_FATAL
[   73.377978] iwlwifi 0000:04:00.0: 0x00000000 | umac branchlink1
[   73.377980] iwlwifi 0000:04:00.0: 0xC0086B38 | umac branchlink2
[   73.377983] iwlwifi 0000:04:00.0: 0xC0083D08 | umac interruptlink1
[   73.377986] iwlwifi 0000:04:00.0: 0xC0083D08 | umac interruptlink2
[   73.377988] iwlwifi 0000:04:00.0: 0x00000800 | umac data1
[   73.377991] iwlwifi 0000:04:00.0: 0xC0083D08 | umac data2
[   73.377994] iwlwifi 0000:04:00.0: 0xDEADBEEF | umac data3
[   73.377996] iwlwifi 0000:04:00.0: 0x00000024 | umac major
[   73.377999] iwlwifi 0000:04:00.0: 0x77D01142 | umac minor
[   73.378001] iwlwifi 0000:04:00.0: 0xC088628C | frame pointer
[   73.378004] iwlwifi 0000:04:00.0: 0xC088628C | stack pointer
[   73.378007] iwlwifi 0000:04:00.0: 0x00F00405 | last host cmd
[   73.378009] iwlwifi 0000:04:00.0: 0x00000000 | isr status reg
[   73.378141] iwlwifi 0000:04:00.0: Fseq Registers:
[   73.378197] iwlwifi 0000:04:00.0: 0x81F5E342 | FSEQ_ERROR_CODE
[   73.378252] iwlwifi 0000:04:00.0: 0x120F8254 | FSEQ_TOP_INIT_VERSION
[   73.378307] iwlwifi 0000:04:00.0: 0x54034CA7 | FSEQ_CNVIO_INIT_VERSION
[   73.378362] iwlwifi 0000:04:00.0: 0x0000A056 | FSEQ_OTP_VERSION
[   73.378417] iwlwifi 0000:04:00.0: 0xCCA632D8 | FSEQ_TOP_CONTENT_VERSION
[   73.378472] iwlwifi 0000:04:00.0: 0xFCBC4F8A | FSEQ_ALIVE_TOKEN
[   73.378527] iwlwifi 0000:04:00.0: 0x377E9CF5 | FSEQ_CNVI_ID
[   73.378582] iwlwifi 0000:04:00.0: 0x7673FF81 | FSEQ_CNVR_ID
[   73.378637] iwlwifi 0000:04:00.0: 0x03000000 | CNVI_AUX_MISC_CHIP
[   73.378695] iwlwifi 0000:04:00.0: 0x0BADCAFE | CNVR_AUX_MISC_CHIP
[   73.378754] iwlwifi 0000:04:00.0: 0x0BADCAFE |
CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[   73.378812] iwlwifi 0000:04:00.0: 0x0BADCAFE |
CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[   73.378877] iwlwifi 0000:04:00.0: Collecting data: trigger 2 fired.
[   73.378886] ieee80211 phy0: Hardware restart was requested
[   73.378904] iwlwifi 0000:04:00.0: FW Error notification: type
0x00000000 cmd_id 0x05
[   73.378910] iwlwifi 0000:04:00.0: FW Error notification: seq 0x00F0
service 0x00000005
[   73.378915] iwlwifi 0000:04:00.0: FW Error notification: timestamp
0x00000000020F2A00
[   73.378972] iwlwifi 0000:04:00.0: FW error in SYNC CMD GEO_TX_POWER_LIMI=
T
[   73.378978] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W
     5.3.1-matteo #81
[   73.378981] Hardware name: LENOVO 20EQS64N1B/20EQS64N1B, BIOS
N1EET84W (1.57 ) 05/09/2019
[   73.379011] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
[   73.379015] Call Trace:
[   73.379029]  dump_stack+0x46/0x60
[   73.379052]  iwl_trans_pcie_send_hcmd+0x505/0x520 [iwlwifi]
[   73.379060]  ? wait_woken+0x70/0x70
[   73.379081]  iwl_trans_send_cmd+0x57/0xb0 [iwlwifi]
[   73.379102]  iwl_mvm_send_cmd+0x23/0x80 [iwlmvm]
[   73.379118]  iwl_mvm_get_sar_geo_profile+0xae/0x130 [iwlmvm]
[   73.379136]  iwl_mvm_rx_chub_update_mcc+0x108/0x1a0 [iwlmvm]
[   73.379152]  iwl_mvm_async_handlers_wk+0xaa/0x140 [iwlmvm]
[   73.379159]  process_one_work+0x1cf/0x370
[   73.379164]  worker_thread+0x4a/0x3c0
[   73.379168]  kthread+0xfb/0x130
[   73.379173]  ? cancel_delayed_work+0x90/0x90
[   73.379176]  ? kthread_create_on_node+0x60/0x60
[   73.379180]  ret_from_fork+0x35/0x40
[   73.379188] iwlwifi 0000:04:00.0: Failed to get geographic profile info =
-5
[   73.379200] ------------[ cut here ]------------
[   73.379251] WARNING: CPU: 2 PID: 64 at
drivers/net/wireless/intel/iwlwifi/mvm/scan.c:1874
iwl_mvm_rx_umac_scan_complete_notif.cold+0xc/0x13 [iwlmvm]
[   73.379253] Modules linked in: cmac ccm xt_MASQUERADE xt_conntrack
ipt_REJECT nf_reject_ipv4 xt_tcpudp tun bridge stp llc iptable_mangle
iptable_nat nf_nat nf_conntrack libcrc32c nf_defrag_ipv4
ip6table_filter ip6_tables iptable_filter ip_tables x_tables rmi_smbus
rmi_core snd_hda_codec_hdmi nls_iso8859_1 vfat fat intel_rapl_msr
iwlmvm snd_hda_codec_realtek snd_hda_codec_generic iTCO_wdt uvcvideo
videobuf2_vmalloc mac80211 snd_hda_intel libarc4 coretemp
videobuf2_memops snd_hda_codec intel_rapl_common videobuf2_v4l2
iosf_mbi snd_hwdep videodev snd_hda_core x86_pkg_temp_thermal snd_seq
intel_powerclamp videobuf2_common snd_seq_device kvm_intel iwlwifi
snd_pcm kvm irqbypass intel_cstate snd_timer rtsx_pci_ms
intel_rapl_perf i2c_i801 memstick psmouse snd efivars soundcore
cfg80211 mei_me mei dm_crypt rtsx_pci_sdmmc mmc_core nouveau hwmon
led_class mxm_wmi drm_kms_helper syscopyarea sysfillrect sysimgblt
fb_sys_fops xhci_pci ttm rtsx_pci xhci_hcd e1000e mfd_core drm agpgart
usbcore usb_common
[   73.379310]  wmi video dm_mod ipv6 nf_defrag_ipv6 autofs4
[   73.379319] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W
     5.3.1-matteo #81
[   73.379320] Hardware name: LENOVO 20EQS64N1B/20EQS64N1B, BIOS
N1EET84W (1.57 ) 05/09/2019
[   73.379337] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
[   73.379360] RIP:
0010:iwl_mvm_rx_umac_scan_complete_notif.cold+0xc/0x13 [iwlmvm]
[   73.379364] Code: 48 c7 c7 18 6e aa a0 e8 bc 6f 66 e0 0f 0b 49 8b
47 10 44 8b a0 9c 00 00 00 e9 8b de fe ff 48 c7 c7 18 6e aa a0 e8 9e
6f 66 e0 <0f> 0b e9 d2 e3 fe ff 48 c7 c7 18 6e aa a0 e8 8b 6f 66 e0 0f
0b 41
[   73.379367] RSP: 0018:ffffc900002a7df0 EFLAGS: 00010246
[   73.379370] RAX: 0000000000000024 RBX: ffff888792c4c000 RCX: 00000000000=
00006
[   73.379372] RDX: 0000000000000000 RSI: 0000000000000096 RDI: ffff888883a=
96370
[   73.379374] RBP: ffff88887cef1e58 R08: 0000000000000001 R09: 00000000000=
00533
[   73.379376] R10: 000000000001ea9c R11: 0000000000000004 R12: ffff88887ce=
f1e28
[   73.379378] R13: ffff88887cef1e28 R14: ffff8887e3696f40 R15: dead0000000=
00100
[   73.379381] FS:  0000000000000000(0000) GS:ffff888883a80000(0000)
knlGS:0000000000000000
[   73.379383] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   73.379385] CR2: 00007fcf67732000 CR3: 0000000001e0a006 CR4: 00000000003=
606e0
[   73.379387] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[   73.379389] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[   73.379391] Call Trace:
[   73.379408]  iwl_mvm_async_handlers_wk+0xaa/0x140 [iwlmvm]
[   73.379415]  process_one_work+0x1cf/0x370
[   73.379419]  worker_thread+0x4a/0x3c0
[   73.379423]  kthread+0xfb/0x130
[   73.379428]  ? cancel_delayed_work+0x90/0x90
[   73.379431]  ? kthread_create_on_node+0x60/0x60
[   73.379434]  ret_from_fork+0x35/0x40
[   73.379438] ---[ end trace c1c6ffcd88e853bc ]---
[   73.966408] iwlwifi 0000:04:00.0: Applying debug destination EXTERNAL_DR=
AM
[   74.117837] iwlwifi 0000:04:00.0: Applying debug destination EXTERNAL_DR=
AM
[   74.204930] iwlwifi 0000:04:00.0: FW already configured (0) - re-configu=
ring
[   74.278332] wlp4s0: authenticate with fc:d4:f2:11:2b:ba
[   74.281639] wlp4s0: send auth to fc:d4:f2:11:2b:ba (try 1/3)
[   74.360321] wlp4s0: authenticated
[   74.364104] wlp4s0: associate with fc:d4:f2:11:2b:ba (try 1/3)
[   74.468101] wlp4s0: associate with fc:d4:f2:11:2b:ba (try 2/3)
[   74.498235] wlp4s0: RX AssocResp from fc:d4:f2:11:2b:ba (capab=3D0x11
status=3D30 aid=3D2)
[   74.498244] wlp4s0: fc:d4:f2:11:2b:ba rejected association
temporarily; comeback duration 1000 TU (1024 ms)
[   74.592674] wlp4s0: RX AssocResp from fc:d4:f2:11:2b:ba (capab=3D0x11
status=3D30 aid=3D2)
[   74.592683] wlp4s0: fc:d4:f2:11:2b:ba rejected association
temporarily; comeback duration 888 TU (909 ms)
[   74.895826] iwlwifi 0000:04:00.0: No beacon heard and the time
event is over already...
[   74.895896] wlp4s0: Connection to AP fc:d4:f2:11:2b:ba lost
[   75.523964] wlp4s0: associate with fc:d4:f2:11:2b:ba (try 3/3)
[   75.632085] wlp4s0: association with fc:d4:f2:11:2b:ba timed out
[   79.331803] iwlwifi 0000:04:00.0: Microcode SW error detected.
Restarting 0x82000000.
[   79.333238] iwlwifi 0000:04:00.0: Start IWL Error Log Dump:
[   79.333239] iwlwifi 0000:04:00.0: Status: 0x00000080, count: 6
[   79.333240] iwlwifi 0000:04:00.0: Loaded firmware version: 36.77d01142.0
[   79.333241] iwlwifi 0000:04:00.0: 0x00000038 | BAD_COMMAND
[   79.333242] iwlwifi 0000:04:00.0: 0x000002F0 | trm_hw_status0
[   79.333243] iwlwifi 0000:04:00.0: 0x00000000 | trm_hw_status1
[   79.333243] iwlwifi 0000:04:00.0: 0x00024200 | branchlink2
[   79.333244] iwlwifi 0000:04:00.0: 0x00039872 | interruptlink1
[   79.333245] iwlwifi 0000:04:00.0: 0x00000000 | interruptlink2
[   79.333245] iwlwifi 0000:04:00.0: 0x004D0405 | data1
[   79.333246] iwlwifi 0000:04:00.0: 0x0000004E | data2
[   79.333247] iwlwifi 0000:04:00.0: 0x0000004E | data3
[   79.333247] iwlwifi 0000:04:00.0: 0x00027131 | beacon time
[   79.333248] iwlwifi 0000:04:00.0: 0x701AE221 | tsf low
[   79.333248] iwlwifi 0000:04:00.0: 0x00000016 | tsf hi
[   79.333249] iwlwifi 0000:04:00.0: 0x00000000 | time gp1
[   79.333250] iwlwifi 0000:04:00.0: 0x004EA1EB | time gp2
[   79.333250] iwlwifi 0000:04:00.0: 0x00000001 | uCode revision type
[   79.333251] iwlwifi 0000:04:00.0: 0x00000024 | uCode version major
[   79.333252] iwlwifi 0000:04:00.0: 0x77D01142 | uCode version minor
[   79.333252] iwlwifi 0000:04:00.0: 0x00000201 | hw version
[   79.333253] iwlwifi 0000:04:00.0: 0x00489008 | board version
[   79.333254] iwlwifi 0000:04:00.0: 0x004D0405 | hcmd
[   79.333254] iwlwifi 0000:04:00.0: 0x00022080 | isr0
[   79.333255] iwlwifi 0000:04:00.0: 0x00000000 | isr1
[   79.333256] iwlwifi 0000:04:00.0: 0x28201802 | isr2
[   79.333256] iwlwifi 0000:04:00.0: 0x00400080 | isr3
[   79.333257] iwlwifi 0000:04:00.0: 0x00000000 | isr4
[   79.333258] iwlwifi 0000:04:00.0: 0x004C01C8 | last cmd Id
[   79.333258] iwlwifi 0000:04:00.0: 0x00000000 | wait_event
[   79.333259] iwlwifi 0000:04:00.0: 0x00000080 | l2p_control
[   79.333259] iwlwifi 0000:04:00.0: 0x00000000 | l2p_duration
[   79.333260] iwlwifi 0000:04:00.0: 0x00000000 | l2p_mhvalid
[   79.333261] iwlwifi 0000:04:00.0: 0x00000000 | l2p_addr_match
[   79.333261] iwlwifi 0000:04:00.0: 0x0000008F | lmpm_pmg_sel
[   79.333262] iwlwifi 0000:04:00.0: 0x19071249 | timestamp
[   79.333263] iwlwifi 0000:04:00.0: 0x000098A8 | flow_handler
[   79.333433] iwlwifi 0000:04:00.0: Start IWL Error Log Dump:
[   79.333434] iwlwifi 0000:04:00.0: Status: 0x00000080, count: 7
[   79.333435] iwlwifi 0000:04:00.0: 0x00000070 | NMI_INTERRUPT_LMAC_FATAL
[   79.333435] iwlwifi 0000:04:00.0: 0x00000000 | umac branchlink1
[   79.333436] iwlwifi 0000:04:00.0: 0xC0086B38 | umac branchlink2
[   79.333437] iwlwifi 0000:04:00.0: 0xC0083D08 | umac interruptlink1
[   79.333437] iwlwifi 0000:04:00.0: 0xC0083D08 | umac interruptlink2
[   79.333438] iwlwifi 0000:04:00.0: 0x00000800 | umac data1
[   79.333439] iwlwifi 0000:04:00.0: 0xC0083D08 | umac data2
[   79.333439] iwlwifi 0000:04:00.0: 0xDEADBEEF | umac data3
[   79.333440] iwlwifi 0000:04:00.0: 0x00000024 | umac major
[   79.333440] iwlwifi 0000:04:00.0: 0x77D01142 | umac minor
[   79.333441] iwlwifi 0000:04:00.0: 0xC088628C | frame pointer
[   79.333442] iwlwifi 0000:04:00.0: 0xC088628C | stack pointer
[   79.333442] iwlwifi 0000:04:00.0: 0x004D0405 | last host cmd
[   79.333443] iwlwifi 0000:04:00.0: 0x00000000 | isr status reg
[   79.333566] iwlwifi 0000:04:00.0: Fseq Registers:
[   79.333571] iwlwifi 0000:04:00.0: 0x81F5E342 | FSEQ_ERROR_CODE
[   79.333575] iwlwifi 0000:04:00.0: 0x120F8254 | FSEQ_TOP_INIT_VERSION
[   79.333580] iwlwifi 0000:04:00.0: 0x54034CA7 | FSEQ_CNVIO_INIT_VERSION
[   79.333584] iwlwifi 0000:04:00.0: 0x0000A056 | FSEQ_OTP_VERSION
[   79.333588] iwlwifi 0000:04:00.0: 0xCCA632D8 | FSEQ_TOP_CONTENT_VERSION
[   79.333592] iwlwifi 0000:04:00.0: 0xFCBC4F8A | FSEQ_ALIVE_TOKEN
[   79.333597] iwlwifi 0000:04:00.0: 0x377E9CF5 | FSEQ_CNVI_ID
[   79.333601] iwlwifi 0000:04:00.0: 0x7673FF81 | FSEQ_CNVR_ID
[   79.333605] iwlwifi 0000:04:00.0: 0x03000000 | CNVI_AUX_MISC_CHIP
[   79.333613] iwlwifi 0000:04:00.0: 0x0BADCAFE | CNVR_AUX_MISC_CHIP
[   79.333620] iwlwifi 0000:04:00.0: 0x0BADCAFE |
CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[   79.333627] iwlwifi 0000:04:00.0: 0x0BADCAFE |
CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[   79.333633] iwlwifi 0000:04:00.0: Collecting data: trigger 2 fired.
[   79.333635] ieee80211 phy0: Hardware restart was requested
[   79.333638] iwlwifi 0000:04:00.0: FW Error notification: type
0x00000000 cmd_id 0x05
[   79.333639] iwlwifi 0000:04:00.0: FW Error notification: seq 0x004D
service 0x00000005
[   79.333640] iwlwifi 0000:04:00.0: FW Error notification: timestamp
0x00000000004EA1E7
[   79.333678] iwlwifi 0000:04:00.0: FW error in SYNC CMD GEO_TX_POWER_LIMI=
T
[   79.333680] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W
     5.3.1-matteo #81
[   79.333681] Hardware name: LENOVO 20EQS64N1B/20EQS64N1B, BIOS
N1EET84W (1.57 ) 05/09/2019
[   79.333689] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
[   79.333690] Call Trace:
[   79.333695]  dump_stack+0x46/0x60
[   79.333715]  iwl_trans_pcie_send_hcmd+0x505/0x520 [iwlwifi]
[   79.333718]  ? wait_woken+0x70/0x70
[   79.333724]  iwl_trans_send_cmd+0x57/0xb0 [iwlwifi]
[   79.333729]  iwl_mvm_send_cmd+0x23/0x80 [iwlmvm]
[   79.333733]  iwl_mvm_get_sar_geo_profile+0xae/0x130 [iwlmvm]
[   79.333738]  iwl_mvm_rx_chub_update_mcc+0x108/0x1a0 [iwlmvm]
[   79.333742]  iwl_mvm_async_handlers_wk+0xaa/0x140 [iwlmvm]
[   79.333744]  process_one_work+0x1cf/0x370
[   79.333745]  worker_thread+0x4a/0x3c0
[   79.333746]  kthread+0xfb/0x130
[   79.333748]  ? cancel_delayed_work+0x90/0x90
[   79.333748]  ? kthread_create_on_node+0x60/0x60
[   79.333750]  ret_from_fork+0x35/0x40
[   79.333754] iwlwifi 0000:04:00.0: Failed to get geographic profile info =
-5
[   79.333758] ------------[ cut here ]------------
[   79.333773] WARNING: CPU: 2 PID: 64 at
drivers/net/wireless/intel/iwlwifi/mvm/scan.c:1874
iwl_mvm_rx_umac_scan_complete_notif.cold+0xc/0x13 [iwlmvm]
[   79.333774] Modules linked in: cmac ccm xt_MASQUERADE xt_conntrack
ipt_REJECT nf_reject_ipv4 xt_tcpudp tun bridge stp llc iptable_mangle
iptable_nat nf_nat nf_conntrack libcrc32c nf_defrag_ipv4
ip6table_filter ip6_tables iptable_filter ip_tables x_tables rmi_smbus
rmi_core snd_hda_codec_hdmi nls_iso8859_1 vfat fat intel_rapl_msr
iwlmvm snd_hda_codec_realtek snd_hda_codec_generic iTCO_wdt uvcvideo
videobuf2_vmalloc mac80211 snd_hda_intel libarc4 coretemp
videobuf2_memops snd_hda_codec intel_rapl_common videobuf2_v4l2
iosf_mbi snd_hwdep videodev snd_hda_core x86_pkg_temp_thermal snd_seq
intel_powerclamp videobuf2_common snd_seq_device kvm_intel iwlwifi
snd_pcm kvm irqbypass intel_cstate snd_timer rtsx_pci_ms
intel_rapl_perf i2c_i801 memstick psmouse snd efivars soundcore
cfg80211 mei_me mei dm_crypt rtsx_pci_sdmmc mmc_core nouveau hwmon
led_class mxm_wmi drm_kms_helper syscopyarea sysfillrect sysimgblt
fb_sys_fops xhci_pci ttm rtsx_pci xhci_hcd e1000e mfd_core drm agpgart
usbcore usb_common
[   79.333793]  wmi video dm_mod ipv6 nf_defrag_ipv6 autofs4
[   79.333796] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W
     5.3.1-matteo #81
[   79.333796] Hardware name: LENOVO 20EQS64N1B/20EQS64N1B, BIOS
N1EET84W (1.57 ) 05/09/2019
[   79.333800] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
[   79.333806] RIP:
0010:iwl_mvm_rx_umac_scan_complete_notif.cold+0xc/0x13 [iwlmvm]
[   79.333807] Code: 48 c7 c7 18 6e aa a0 e8 bc 6f 66 e0 0f 0b 49 8b
47 10 44 8b a0 9c 00 00 00 e9 8b de fe ff 48 c7 c7 18 6e aa a0 e8 9e
6f 66 e0 <0f> 0b e9 d2 e3 fe ff 48 c7 c7 18 6e aa a0 e8 8b 6f 66 e0 0f
0b 41
[   79.333807] RSP: 0018:ffffc900002a7df0 EFLAGS: 00010246
[   79.333808] RAX: 0000000000000024 RBX: ffff8887a9e41000 RCX: 00000000000=
00006
[   79.333809] RDX: 0000000000000000 RSI: 0000000000000096 RDI: ffff888883a=
96370
[   79.333809] RBP: ffff88887cef1e58 R08: 0000000000000001 R09: 00000000000=
005bc
[   79.333810] R10: 0000000000021ec4 R11: 0000000000000004 R12: ffff88887ce=
f1e28
[   79.333810] R13: ffff88887cef1e28 R14: ffff8887e3696940 R15: dead0000000=
00100
[   79.333811] FS:  0000000000000000(0000) GS:ffff888883a80000(0000)
knlGS:0000000000000000
[   79.333812] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   79.333812] CR2: 00002e8e36a82000 CR3: 0000000001e0a004 CR4: 00000000003=
606e0
[   79.333813] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[   79.333813] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[   79.333814] Call Trace:
[   79.333818]  iwl_mvm_async_handlers_wk+0xaa/0x140 [iwlmvm]
[   79.333820]  process_one_work+0x1cf/0x370
[   79.333821]  worker_thread+0x4a/0x3c0
[   79.333822]  kthread+0xfb/0x130
[   79.333823]  ? cancel_delayed_work+0x90/0x90
[   79.333824]  ? kthread_create_on_node+0x60/0x60
[   79.333825]  ret_from_fork+0x35/0x40
[   79.333826] ---[ end trace c1c6ffcd88e853bd ]---
[   79.972512] iwlwifi 0000:04:00.0: Applying debug destination EXTERNAL_DR=
AM
[   80.123002] iwlwifi 0000:04:00.0: Applying debug destination EXTERNAL_DR=
AM
[   80.203866] iwlwifi 0000:04:00.0: FW already configured (0) - re-configu=
ring
[   88.508299] iwlwifi 0000:04:00.0: Microcode SW error detected.
Restarting 0x82000000.
[   88.508594] iwlwifi 0000:04:00.0: Start IWL Error Log Dump:
[   88.508595] iwlwifi 0000:04:00.0: Status: 0x00000080, count: 6
[   88.508596] iwlwifi 0000:04:00.0: Loaded firmware version: 36.77d01142.0
[   88.508597] iwlwifi 0000:04:00.0: 0x00000038 | BAD_COMMAND
[   88.508598] iwlwifi 0000:04:00.0: 0x000002F0 | trm_hw_status0
[   88.508599] iwlwifi 0000:04:00.0: 0x00000000 | trm_hw_status1
[   88.508600] iwlwifi 0000:04:00.0: 0x00024200 | branchlink2
[   88.508601] iwlwifi 0000:04:00.0: 0x00039872 | interruptlink1
[   88.508601] iwlwifi 0000:04:00.0: 0x00000000 | interruptlink2
[   88.508602] iwlwifi 0000:04:00.0: 0x003C0405 | data1
[   88.508603] iwlwifi 0000:04:00.0: 0x0000003D | data2
[   88.508604] iwlwifi 0000:04:00.0: 0x0000003D | data3
[   88.508605] iwlwifi 0000:04:00.0: 0x0003EB18 | beacon time
[   88.508605] iwlwifi 0000:04:00.0: 0x007F0E6C | tsf low
[   88.508606] iwlwifi 0000:04:00.0: 0x00000000 | tsf hi
[   88.508607] iwlwifi 0000:04:00.0: 0x00000000 | time gp1
[   88.508608] iwlwifi 0000:04:00.0: 0x007F0E6D | time gp2
[   88.508608] iwlwifi 0000:04:00.0: 0x00000001 | uCode revision type
[   88.508609] iwlwifi 0000:04:00.0: 0x00000024 | uCode version major
[   88.508610] iwlwifi 0000:04:00.0: 0x77D01142 | uCode version minor
[   88.508611] iwlwifi 0000:04:00.0: 0x00000201 | hw version
[   88.508612] iwlwifi 0000:04:00.0: 0x00489008 | board version
[   88.508613] iwlwifi 0000:04:00.0: 0x003C0405 | hcmd
[   88.508613] iwlwifi 0000:04:00.0: 0x00022080 | isr0
[   88.508614] iwlwifi 0000:04:00.0: 0x00000000 | isr1
[   88.508615] iwlwifi 0000:04:00.0: 0x28201802 | isr2
[   88.508616] iwlwifi 0000:04:00.0: 0x00400080 | isr3
[   88.508616] iwlwifi 0000:04:00.0: 0x00000000 | isr4
[   88.508617] iwlwifi 0000:04:00.0: 0x003B01C8 | last cmd Id
[   88.508618] iwlwifi 0000:04:00.0: 0x00000000 | wait_event
[   88.508619] iwlwifi 0000:04:00.0: 0x00000080 | l2p_control
[   88.508620] iwlwifi 0000:04:00.0: 0x00000000 | l2p_duration
[   88.508620] iwlwifi 0000:04:00.0: 0x00000000 | l2p_mhvalid
[   88.508621] iwlwifi 0000:04:00.0: 0x00000000 | l2p_addr_match
[   88.508622] iwlwifi 0000:04:00.0: 0x0000008F | lmpm_pmg_sel
[   88.508623] iwlwifi 0000:04:00.0: 0x19071249 | timestamp
[   88.508624] iwlwifi 0000:04:00.0: 0x00006070 | flow_handler
[   88.508803] iwlwifi 0000:04:00.0: Start IWL Error Log Dump:
[   88.508804] iwlwifi 0000:04:00.0: Status: 0x00000080, count: 7
[   88.508805] iwlwifi 0000:04:00.0: 0x00000070 | NMI_INTERRUPT_LMAC_FATAL
[   88.508806] iwlwifi 0000:04:00.0: 0x00000000 | umac branchlink1
[   88.508806] iwlwifi 0000:04:00.0: 0xC0086B38 | umac branchlink2
[   88.508807] iwlwifi 0000:04:00.0: 0xC0083D08 | umac interruptlink1
[   88.508808] iwlwifi 0000:04:00.0: 0xC0083D08 | umac interruptlink2
[   88.508809] iwlwifi 0000:04:00.0: 0x00000800 | umac data1
[   88.508810] iwlwifi 0000:04:00.0: 0xC0083D08 | umac data2
[   88.508810] iwlwifi 0000:04:00.0: 0xDEADBEEF | umac data3
[   88.508811] iwlwifi 0000:04:00.0: 0x00000024 | umac major
[   88.508812] iwlwifi 0000:04:00.0: 0x77D01142 | umac minor
[   88.508813] iwlwifi 0000:04:00.0: 0xC088628C | frame pointer
[   88.508813] iwlwifi 0000:04:00.0: 0xC088628C | stack pointer
[   88.508814] iwlwifi 0000:04:00.0: 0x003C0405 | last host cmd
[   88.508815] iwlwifi 0000:04:00.0: 0x00000000 | isr status reg
[   88.508939] iwlwifi 0000:04:00.0: Fseq Registers:
[   88.508943] iwlwifi 0000:04:00.0: 0x81F5E342 | FSEQ_ERROR_CODE
[   88.508948] iwlwifi 0000:04:00.0: 0x120F8254 | FSEQ_TOP_INIT_VERSION
[   88.508952] iwlwifi 0000:04:00.0: 0x54034CA7 | FSEQ_CNVIO_INIT_VERSION
[   88.508957] iwlwifi 0000:04:00.0: 0x0000A056 | FSEQ_OTP_VERSION
[   88.508961] iwlwifi 0000:04:00.0: 0xCCA632D8 | FSEQ_TOP_CONTENT_VERSION
[   88.508966] iwlwifi 0000:04:00.0: 0xFCBC4F8A | FSEQ_ALIVE_TOKEN
[   88.508970] iwlwifi 0000:04:00.0: 0x377E9CF5 | FSEQ_CNVI_ID
[   88.508974] iwlwifi 0000:04:00.0: 0x7673FF81 | FSEQ_CNVR_ID
[   88.508979] iwlwifi 0000:04:00.0: 0x03000000 | CNVI_AUX_MISC_CHIP
[   88.508986] iwlwifi 0000:04:00.0: 0x0BADCAFE | CNVR_AUX_MISC_CHIP
[   88.508994] iwlwifi 0000:04:00.0: 0x0BADCAFE |
CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[   88.509002] iwlwifi 0000:04:00.0: 0x0BADCAFE |
CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[   88.509054] iwlwifi 0000:04:00.0: Collecting data: trigger 2 fired.
[   88.509057] ieee80211 phy0: Hardware restart was requested
[   88.509060] iwlwifi 0000:04:00.0: FW Error notification: type
0x00000000 cmd_id 0x05
[   88.509061] iwlwifi 0000:04:00.0: FW Error notification: seq 0x003C
service 0x00000005
[   88.509062] iwlwifi 0000:04:00.0: FW Error notification: timestamp
0x00000000007F0E69
[   88.509068] iwlwifi 0000:04:00.0: FW error in SYNC CMD GEO_TX_POWER_LIMI=
T
[   88.509070] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W
     5.3.1-matteo #81
[   88.509070] Hardware name: LENOVO 20EQS64N1B/20EQS64N1B, BIOS
N1EET84W (1.57 ) 05/09/2019
[   88.509080] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
[   88.509081] Call Trace:
[   88.509086]  dump_stack+0x46/0x60
[   88.509094]  iwl_trans_pcie_send_hcmd+0x505/0x520 [iwlwifi]
[   88.509097]  ? wait_woken+0x70/0x70
[   88.509104]  iwl_trans_send_cmd+0x57/0xb0 [iwlwifi]
[   88.509111]  iwl_mvm_send_cmd+0x23/0x80 [iwlmvm]
[   88.509116]  iwl_mvm_get_sar_geo_profile+0xae/0x130 [iwlmvm]
[   88.509121]  iwl_mvm_rx_chub_update_mcc+0x108/0x1a0 [iwlmvm]
[   88.509126]  iwl_mvm_async_handlers_wk+0xaa/0x140 [iwlmvm]
[   88.509129]  process_one_work+0x1cf/0x370
[   88.509131]  worker_thread+0x4a/0x3c0
[   88.509132]  kthread+0xfb/0x130
[   88.509133]  ? cancel_delayed_work+0x90/0x90
[   88.509134]  ? kthread_create_on_node+0x60/0x60
[   88.509135]  ret_from_fork+0x35/0x40
[   88.509138] iwlwifi 0000:04:00.0: Failed to get geographic profile info =
-5
[   88.509142] ------------[ cut here ]------------
[   88.509163] WARNING: CPU: 2 PID: 64 at
drivers/net/wireless/intel/iwlwifi/mvm/scan.c:1874
iwl_mvm_rx_umac_scan_complete_notif.cold+0xc/0x13 [iwlmvm]
[   88.509163] Modules linked in: cmac ccm xt_MASQUERADE xt_conntrack
ipt_REJECT nf_reject_ipv4 xt_tcpudp tun bridge stp llc iptable_mangle
iptable_nat nf_nat nf_conntrack libcrc32c nf_defrag_ipv4
ip6table_filter ip6_tables iptable_filter ip_tables x_tables rmi_smbus
rmi_core snd_hda_codec_hdmi nls_iso8859_1 vfat fat intel_rapl_msr
iwlmvm snd_hda_codec_realtek snd_hda_codec_generic iTCO_wdt uvcvideo
videobuf2_vmalloc mac80211 snd_hda_intel libarc4 coretemp
videobuf2_memops snd_hda_codec intel_rapl_common videobuf2_v4l2
iosf_mbi snd_hwdep videodev snd_hda_core x86_pkg_temp_thermal snd_seq
intel_powerclamp videobuf2_common snd_seq_device kvm_intel iwlwifi
snd_pcm kvm irqbypass intel_cstate snd_timer rtsx_pci_ms
intel_rapl_perf i2c_i801 memstick psmouse snd efivars soundcore
cfg80211 mei_me mei dm_crypt rtsx_pci_sdmmc mmc_core nouveau hwmon
led_class mxm_wmi drm_kms_helper syscopyarea sysfillrect sysimgblt
fb_sys_fops xhci_pci ttm rtsx_pci xhci_hcd e1000e mfd_core drm agpgart
usbcore usb_common
[   88.509185]  wmi video dm_mod ipv6 nf_defrag_ipv6 autofs4
[   88.509188] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W
     5.3.1-matteo #81
[   88.509188] Hardware name: LENOVO 20EQS64N1B/20EQS64N1B, BIOS
N1EET84W (1.57 ) 05/09/2019
[   88.509193] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
[   88.509201] RIP:
0010:iwl_mvm_rx_umac_scan_complete_notif.cold+0xc/0x13 [iwlmvm]
[   88.509202] Code: 48 c7 c7 18 6e aa a0 e8 bc 6f 66 e0 0f 0b 49 8b
47 10 44 8b a0 9c 00 00 00 e9 8b de fe ff 48 c7 c7 18 6e aa a0 e8 9e
6f 66 e0 <0f> 0b e9 d2 e3 fe ff 48 c7 c7 18 6e aa a0 e8 8b 6f 66 e0 0f
0b 41
[   88.509203] RSP: 0000:ffffc900002a7df0 EFLAGS: 00010246
[   88.509204] RAX: 0000000000000024 RBX: ffff8887a9e18000 RCX: 00000000000=
00006
[   88.509205] RDX: 0000000000000000 RSI: 0000000000000096 RDI: ffff888883a=
96370
[   88.509205] RBP: ffff88887cef1e58 R08: 0000000000000001 R09: 00000000000=
00638
[   88.509206] R10: 0000000000024ee4 R11: 0000000000000004 R12: ffff88887ce=
f1e28
[   88.509206] R13: ffff88887cef1e28 R14: ffff8887e36961c0 R15: dead0000000=
00100
[   88.509207] FS:  0000000000000000(0000) GS:ffff888883a80000(0000)
knlGS:0000000000000000
[   88.509208] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   88.509209] CR2: 00007fa2b99a7024 CR3: 00000007b82c4002 CR4: 00000000003=
606e0
[   88.509209] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[   88.509210] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[   88.509210] Call Trace:
[   88.509216]  iwl_mvm_async_handlers_wk+0xaa/0x140 [iwlmvm]
[   88.509217]  process_one_work+0x1cf/0x370
[   88.509219]  worker_thread+0x225/0x3c0
[   88.509220]  kthread+0xfb/0x130
[   88.509221]  ? cancel_delayed_work+0x90/0x90
[   88.509222]  ? kthread_create_on_node+0x60/0x60
[   88.509223]  ret_from_fork+0x35/0x40
[   88.509225] ---[ end trace c1c6ffcd88e853be ]---
[   89.191879] iwlwifi 0000:04:00.0: Applying debug destination EXTERNAL_DR=
AM
[   89.338862] iwlwifi 0000:04:00.0: Applying debug destination EXTERNAL_DR=
AM
[   89.419149] iwlwifi 0000:04:00.0: FW already configured (0) - re-configu=
ring
[   91.303918] iwlwifi 0000:04:00.0: regular scan timed out
[   91.304300] iwlwifi 0000:04:00.0: Microcode SW error detected.
Restarting 0x2000000.
[   91.304527] iwlwifi 0000:04:00.0: Start IWL Error Log Dump:
[   91.304531] iwlwifi 0000:04:00.0: Status: 0x00000080, count: 6
[   91.304534] iwlwifi 0000:04:00.0: Loaded firmware version: 36.77d01142.0
[   91.304538] iwlwifi 0000:04:00.0: 0x00000084 | NMI_INTERRUPT_UNKNOWN
[   91.304541] iwlwifi 0000:04:00.0: 0x000002B0 | trm_hw_status0
[   91.304543] iwlwifi 0000:04:00.0: 0x00000000 | trm_hw_status1
[   91.304546] iwlwifi 0000:04:00.0: 0x00024200 | branchlink2
[   91.304548] iwlwifi 0000:04:00.0: 0x00039872 | interruptlink1
[   91.304551] iwlwifi 0000:04:00.0: 0x00048868 | interruptlink2
[   91.304553] iwlwifi 0000:04:00.0: 0x00000000 | data1
[   91.304555] iwlwifi 0000:04:00.0: 0x00000080 | data2
[   91.304558] iwlwifi 0000:04:00.0: 0x07830000 | data3
[   91.304560] iwlwifi 0000:04:00.0: 0x0022E682 | beacon time
[   91.304562] iwlwifi 0000:04:00.0: 0x001D197C | tsf low
[   91.304565] iwlwifi 0000:04:00.0: 0x00000000 | tsf hi
[   91.304567] iwlwifi 0000:04:00.0: 0x00000000 | time gp1
[   91.304570] iwlwifi 0000:04:00.0: 0x001D197D | time gp2
[   91.304572] iwlwifi 0000:04:00.0: 0x00000001 | uCode revision type
[   91.304574] iwlwifi 0000:04:00.0: 0x00000024 | uCode version major
[   91.304577] iwlwifi 0000:04:00.0: 0x77D01142 | uCode version minor
[   91.304579] iwlwifi 0000:04:00.0: 0x00000201 | hw version
[   91.304582] iwlwifi 0000:04:00.0: 0x00489008 | board version
[   91.304584] iwlwifi 0000:04:00.0: 0x0000001C | hcmd
[   91.304587] iwlwifi 0000:04:00.0: 0x00022000 | isr0
[   91.304589] iwlwifi 0000:04:00.0: 0x00800000 | isr1
[   91.304591] iwlwifi 0000:04:00.0: 0x08001802 | isr2
[   91.304593] iwlwifi 0000:04:00.0: 0x0041FCC0 | isr3
[   91.304596] iwlwifi 0000:04:00.0: 0x00000000 | isr4
[   91.304598] iwlwifi 0000:04:00.0: 0x803AFB03 | last cmd Id
[   91.304600] iwlwifi 0000:04:00.0: 0x00000000 | wait_event
[   91.304603] iwlwifi 0000:04:00.0: 0x00000080 | l2p_control
[   91.304605] iwlwifi 0000:04:00.0: 0x00010020 | l2p_duration
[   91.304608] iwlwifi 0000:04:00.0: 0x0000003F | l2p_mhvalid
[   91.304610] iwlwifi 0000:04:00.0: 0x00000080 | l2p_addr_match
[   91.304613] iwlwifi 0000:04:00.0: 0x0000000D | lmpm_pmg_sel
[   91.304615] iwlwifi 0000:04:00.0: 0x19071249 | timestamp
[   91.304617] iwlwifi 0000:04:00.0: 0x00345860 | flow_handler
[   91.304791] iwlwifi 0000:04:00.0: Start IWL Error Log Dump:
[   91.304794] iwlwifi 0000:04:00.0: Status: 0x00000080, count: 7
[   91.304797] iwlwifi 0000:04:00.0: 0x00000070 | NMI_INTERRUPT_LMAC_FATAL
[   91.304800] iwlwifi 0000:04:00.0: 0x00000000 | umac branchlink1
[   91.304802] iwlwifi 0000:04:00.0: 0xC0086B38 | umac branchlink2
[   91.304805] iwlwifi 0000:04:00.0: 0xC0083D08 | umac interruptlink1
[   91.304807] iwlwifi 0000:04:00.0: 0xC0083D08 | umac interruptlink2
[   91.304809] iwlwifi 0000:04:00.0: 0x00000800 | umac data1
[   91.304812] iwlwifi 0000:04:00.0: 0xC0083D08 | umac data2
[   91.304814] iwlwifi 0000:04:00.0: 0xDEADBEEF | umac data3
[   91.304816] iwlwifi 0000:04:00.0: 0x00000024 | umac major
[   91.304819] iwlwifi 0000:04:00.0: 0x77D01142 | umac minor
[   91.304821] iwlwifi 0000:04:00.0: 0xC088628C | frame pointer
[   91.304823] iwlwifi 0000:04:00.0: 0xC088628C | stack pointer
[   91.304826] iwlwifi 0000:04:00.0: 0x003A010D | last host cmd
[   91.304828] iwlwifi 0000:04:00.0: 0x00000000 | isr status reg
[   91.304960] iwlwifi 0000:04:00.0: Fseq Registers:
[   91.305015] iwlwifi 0000:04:00.0: 0x81F5E342 | FSEQ_ERROR_CODE
[   91.305070] iwlwifi 0000:04:00.0: 0x120F8254 | FSEQ_TOP_INIT_VERSION
[   91.305125] iwlwifi 0000:04:00.0: 0x54034CA7 | FSEQ_CNVIO_INIT_VERSION
[   91.305181] iwlwifi 0000:04:00.0: 0x0000A056 | FSEQ_OTP_VERSION
[   91.305236] iwlwifi 0000:04:00.0: 0xCCA632D8 | FSEQ_TOP_CONTENT_VERSION
[   91.305291] iwlwifi 0000:04:00.0: 0xFCBC4F8A | FSEQ_ALIVE_TOKEN
[   91.305346] iwlwifi 0000:04:00.0: 0x377E9CF5 | FSEQ_CNVI_ID
[   91.305401] iwlwifi 0000:04:00.0: 0x7673FF81 | FSEQ_CNVR_ID
[   91.305456] iwlwifi 0000:04:00.0: 0x03000000 | CNVI_AUX_MISC_CHIP
[   91.305514] iwlwifi 0000:04:00.0: 0x0BADCAFE | CNVR_AUX_MISC_CHIP
[   91.305573] iwlwifi 0000:04:00.0: 0x0BADCAFE |
CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[   91.305631] iwlwifi 0000:04:00.0: 0x0BADCAFE |
CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[   91.305691] iwlwifi 0000:04:00.0: Collecting data: trigger 2 fired.
[   91.305698] ieee80211 phy0: Hardware restart was requested
[   91.967590] iwlwifi 0000:04:00.0: Applying debug destination EXTERNAL_DR=
AM
[   92.117459] iwlwifi 0000:04:00.0: Applying debug destination EXTERNAL_DR=
AM
[   92.202999] iwlwifi 0000:04:00.0: FW already configured (0) - re-configu=
ring

Reverting the patch fixes it, this is my card:

$ lspci -d ::280
04:00.0 Network controller: Intel Corporation Wireless 8260 (rev 3a)

--=20
Matteo Croce
per aspera ad upstream

