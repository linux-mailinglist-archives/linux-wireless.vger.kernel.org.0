Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90A5C1062E
	for <lists+linux-wireless@lfdr.de>; Wed,  1 May 2019 10:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfEAIm3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 May 2019 04:42:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:47356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfEAIm3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 May 2019 04:42:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E72C021734;
        Wed,  1 May 2019 08:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556700147;
        bh=gvtCgkCen3RuPmR/m1zCSUBxL6oDhN9NLDwCIuQ67NA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zo0a/mIrvrRacqS4hlh7LJTaTJbcOWVVY+PX/cHyQzacC72bNikR5Fx+Sw09VXES6
         FYjdBiOV9hC50w8ejsl34jr/aUwFbhhlXa32SWUlwySGYasSZd8GKywgEt4JKLSst7
         va37C/g9OiJpNSOsIJhrnQWS9wkaEWrtzL7j8GBI=
Date:   Wed, 1 May 2019 10:42:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Stanislaw Gruszka <sgruszka@redhat.com>, yhchuang@realtek.com,
        linux-wireless@vger.kernel.org, johannes@sipsolutions.net,
        pkshih@realtek.com, tehuang@realtek.com, Larry.Finger@lwfinger.net,
        briannorris@chromium.org
Subject: Re: [PATCH v9 00/14] rtw88: mac80211 driver for Realtek 802.11ac
 wireless network chips
Message-ID: <20190501084225.GA21329@kroah.com>
References: <1555653004-1795-1-git-send-email-yhchuang@realtek.com>
 <87sgtzwtst.fsf@purkki.adurom.net>
 <20190430155808.GA3019@redhat.com>
 <87v9yvo2y6.fsf@kamboji.qca.qualcomm.com>
 <20190430174234.GA16336@kroah.com>
 <87muk6odld.fsf@kamboji.qca.qualcomm.com>
 <20190501081935.GB15425@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <20190501081935.GB15425@kroah.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 01, 2019 at 10:19:35AM +0200, Greg KH wrote:
> On Wed, May 01, 2019 at 10:09:34AM +0300, Kalle Valo wrote:
> > Greg KH <gregkh@linuxfoundation.org> writes:
> > 
> > > On Tue, Apr 30, 2019 at 07:47:13PM +0300, Kalle Valo wrote:
> > >> Stanislaw Gruszka <sgruszka@redhat.com> writes:
> > >> 
> > >> > On Tue, Apr 30, 2019 at 03:40:02PM +0300, Kalle Valo wrote:
> > >> >> > From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> > >> >> >
> > >> >> > This is a new mac80211 driver for Realtek 802.11ac wireless network chips.
> > >> >> > rtw88 now supports RTL8822BE/RTL8822CE now, with basic station mode
> > >> >> > functionalities. The firmware for both can be found at linux-firmware.
> > >> >> 
> > >> >> This looks very good now. I did a quick review of the driver and had few
> > >> >> netpicks but nothing really blocking applying this. So I have now
> > >> >> combined these patches into one big patch and pushed it to the pending
> > >> >> branch:
> > >> >> 
> > >> >> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git/commit/?h=pending&id=284d1e4e3311cfe67c1c57ccc275ff0f5666aeea
> > >> >> 
> > >> >> I appreciate if people could do a quick check and make sure that I
> > >> >> didn't do anything stupid when folding the patches.
> > >> >
> > >> > I've build pending branch and done few quick tests on Realtek
> > >> > 8822CE device. Everything works ok.
> > >> 
> > >> Thanks so much for this, I now feel much more comfortable merging it :)
> > >> 
> > >> So this is manually applied to wireless-drivers-next:
> > >> 
> > >> e3037485c68e rtw88: new Realtek 802.11ac driver
> > >> 
> > >> And it should be in tomorrow's linux-next build, let's see what kind of
> > >> reports we get. Greg, feel free to delete the corresponding staging
> > >> driver from your tree (I forgot the name of the driver already).
> > >
> > > I'll be glad to do so if someone also tells me what the driver's name is
> > > as well, I don't remember either :)
> > 
> > I checked it now, the directory is drivers/staging/rtlwifi. Here's the
> > commit adding the upstream driver, in case you need that in the commit
> > log:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git/commit/?id=e3037485c68ec1a299ff41160d8fedbd4abc29b9
> 
> Thanks for this, now dropped from my tree (with the exception of 2 .h
> files which a different driver used, and I'll clean that up as well with
> a later patch.)

Attached below are the 2 follow-on patches that I have applied that
clean up the remaining .h rtlwifi files, and then move them into the
location where they are used.

thanks,

greg k-h

--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-staging-rtlwifi-strip-down-phydm-.h-files.patch"

From 8a90bdcb64a9e3732279bb6d9f5054dd6ce3dfbd Mon Sep 17 00:00:00 2001
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Wed, 1 May 2019 10:37:13 +0200
Subject: [PATCH 1/2] staging: rtlwifi: strip down phydm .h files

The phydm .h files are used by another driver, but not all of the
defines are used, so strip them down to their basic necessities before
we move them out of this directory.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/rtlwifi/phydm/phydm_reg.h     | 118 --------------
 .../rtlwifi/phydm/phydm_regdefine11n.h        | 153 +-----------------
 2 files changed, 2 insertions(+), 269 deletions(-)

diff --git a/drivers/staging/rtlwifi/phydm/phydm_reg.h b/drivers/staging/rtlwifi/phydm/phydm_reg.h
index 562c1199d669..e3ae006487ba 100644
--- a/drivers/staging/rtlwifi/phydm/phydm_reg.h
+++ b/drivers/staging/rtlwifi/phydm/phydm_reg.h
@@ -11,130 +11,12 @@
  * Larry Finger <Larry.Finger@lwfinger.net>
  *
  *****************************************************************************/
-/* ************************************************************
- * File Name: odm_reg.h
- *
- * Description:
- *
- * This file is for general register definition.
- *
- *
- * *************************************************************/
 #ifndef __HAL_ODM_REG_H__
 #define __HAL_ODM_REG_H__
 
-/*
- * Register Definition
- */
-
-/* MAC REG */
-#define ODM_BB_RESET 0x002
-#define ODM_DUMMY 0x4fe
-#define RF_T_METER_OLD 0x24
-#define RF_T_METER_NEW 0x42
-
 #define ODM_EDCA_VO_PARAM 0x500
 #define ODM_EDCA_VI_PARAM 0x504
 #define ODM_EDCA_BE_PARAM 0x508
 #define ODM_EDCA_BK_PARAM 0x50C
-#define ODM_TXPAUSE 0x522
-
-/* LTE_COEX */
-#define REG_LTECOEX_CTRL 0x07C0
-#define REG_LTECOEX_WRITE_DATA 0x07C4
-#define REG_LTECOEX_READ_DATA 0x07C8
-#define REG_LTECOEX_PATH_CONTROL 0x70
-
-/* BB REG */
-#define ODM_FPGA_PHY0_PAGE8 0x800
-#define ODM_PSD_SETTING 0x808
-#define ODM_AFE_SETTING 0x818
-#define ODM_TXAGC_B_6_18 0x830
-#define ODM_TXAGC_B_24_54 0x834
-#define ODM_TXAGC_B_MCS32_5 0x838
-#define ODM_TXAGC_B_MCS0_MCS3 0x83c
-#define ODM_TXAGC_B_MCS4_MCS7 0x848
-#define ODM_TXAGC_B_MCS8_MCS11 0x84c
-#define ODM_ANALOG_REGISTER 0x85c
-#define ODM_RF_INTERFACE_OUTPUT 0x860
-#define ODM_TXAGC_B_MCS12_MCS15 0x868
-#define ODM_TXAGC_B_11_A_2_11 0x86c
-#define ODM_AD_DA_LSB_MASK 0x874
-#define ODM_ENABLE_3_WIRE 0x88c
-#define ODM_PSD_REPORT 0x8b4
-#define ODM_R_ANT_SELECT 0x90c
-#define ODM_CCK_ANT_SELECT 0xa07
-#define ODM_CCK_PD_THRESH 0xa0a
-#define ODM_CCK_RF_REG1 0xa11
-#define ODM_CCK_MATCH_FILTER 0xa20
-#define ODM_CCK_RAKE_MAC 0xa2e
-#define ODM_CCK_CNT_RESET 0xa2d
-#define ODM_CCK_TX_DIVERSITY 0xa2f
-#define ODM_CCK_FA_CNT_MSB 0xa5b
-#define ODM_CCK_FA_CNT_LSB 0xa5c
-#define ODM_CCK_NEW_FUNCTION 0xa75
-#define ODM_OFDM_PHY0_PAGE_C 0xc00
-#define ODM_OFDM_RX_ANT 0xc04
-#define ODM_R_A_RXIQI 0xc14
-#define ODM_R_A_AGC_CORE1 0xc50
-#define ODM_R_A_AGC_CORE2 0xc54
-#define ODM_R_B_AGC_CORE1 0xc58
-#define ODM_R_AGC_PAR 0xc70
-#define ODM_R_HTSTF_AGC_PAR 0xc7c
-#define ODM_TX_PWR_TRAINING_A 0xc90
-#define ODM_TX_PWR_TRAINING_B 0xc98
-#define ODM_OFDM_FA_CNT1 0xcf0
-#define ODM_OFDM_PHY0_PAGE_D 0xd00
-#define ODM_OFDM_FA_CNT2 0xda0
-#define ODM_OFDM_FA_CNT3 0xda4
-#define ODM_OFDM_FA_CNT4 0xda8
-#define ODM_TXAGC_A_6_18 0xe00
-#define ODM_TXAGC_A_24_54 0xe04
-#define ODM_TXAGC_A_1_MCS32 0xe08
-#define ODM_TXAGC_A_MCS0_MCS3 0xe10
-#define ODM_TXAGC_A_MCS4_MCS7 0xe14
-#define ODM_TXAGC_A_MCS8_MCS11 0xe18
-#define ODM_TXAGC_A_MCS12_MCS15 0xe1c
-
-/* RF REG */
-#define ODM_GAIN_SETTING 0x00
-#define ODM_CHANNEL 0x18
-#define ODM_RF_T_METER 0x24
-#define ODM_RF_T_METER_92D 0x42
-#define ODM_RF_T_METER_88E 0x42
-#define ODM_RF_T_METER_92E 0x42
-#define ODM_RF_T_METER_8812 0x42
-#define REG_RF_TX_GAIN_OFFSET 0x55
-
-/* ant Detect Reg */
-#define ODM_DPDT 0x300
-
-/* PSD Init */
-#define ODM_PSDREG 0x808
-
-/* 92D path Div */
-#define PATHDIV_REG 0xB30
-#define PATHDIV_TRI 0xBA0
-
-/*
- * Bitmap Definition
- */
-
-#define BIT_FA_RESET BIT(0)
-
-#define REG_OFDM_0_XA_TX_IQ_IMBALANCE 0xC80
-#define REG_OFDM_0_ECCA_THRESHOLD 0xC4C
-#define REG_FPGA0_XB_LSSI_READ_BACK 0x8A4
-#define REG_FPGA0_TX_GAIN_STAGE 0x80C
-#define REG_OFDM_0_XA_AGC_CORE1 0xC50
-#define REG_OFDM_0_XB_AGC_CORE1 0xC58
-#define REG_A_TX_SCALE_JAGUAR 0xC1C
-#define REG_B_TX_SCALE_JAGUAR 0xE1C
-
-#define REG_AFE_XTAL_CTRL 0x0024
-#define REG_AFE_PLL_CTRL 0x0028
-#define REG_MAC_PHY_CTRL 0x002C
-
-#define RF_CHNLBW 0x18
 
 #endif
diff --git a/drivers/staging/rtlwifi/phydm/phydm_regdefine11n.h b/drivers/staging/rtlwifi/phydm/phydm_regdefine11n.h
index 765e0a0c8c7b..565996828cab 100644
--- a/drivers/staging/rtlwifi/phydm/phydm_regdefine11n.h
+++ b/drivers/staging/rtlwifi/phydm/phydm_regdefine11n.h
@@ -15,188 +15,39 @@
 #ifndef __ODM_REGDEFINE11N_H__
 #define __ODM_REGDEFINE11N_H__
 
-/* 2 RF REG LIST */
-#define ODM_REG_RF_MODE_11N 0x00
-#define ODM_REG_RF_0B_11N 0x0B
-#define ODM_REG_CHNBW_11N 0x18
-#define ODM_REG_T_METER_11N 0x24
-#define ODM_REG_RF_25_11N 0x25
-#define ODM_REG_RF_26_11N 0x26
-#define ODM_REG_RF_27_11N 0x27
-#define ODM_REG_RF_2B_11N 0x2B
-#define ODM_REG_RF_2C_11N 0x2C
-#define ODM_REG_RXRF_A3_11N 0x3C
-#define ODM_REG_T_METER_92D_11N 0x42
-#define ODM_REG_T_METER_88E_11N 0x42
-
-/* 2 BB REG LIST */
-/* PAGE 8 */
-#define ODM_REG_BB_CTRL_11N 0x800
-#define ODM_REG_RF_PIN_11N 0x804
-#define ODM_REG_PSD_CTRL_11N 0x808
 #define ODM_REG_TX_ANT_CTRL_11N 0x80C
-#define ODM_REG_BB_PWR_SAV5_11N 0x818
-#define ODM_REG_CCK_RPT_FORMAT_11N 0x824
-#define ODM_REG_CCK_RPT_FORMAT_11N_B 0x82C
 #define ODM_REG_RX_DEFAULT_A_11N 0x858
-#define ODM_REG_RX_DEFAULT_B_11N 0x85A
-#define ODM_REG_BB_PWR_SAV3_11N 0x85C
 #define ODM_REG_ANTSEL_CTRL_11N 0x860
 #define ODM_REG_RX_ANT_CTRL_11N 0x864
 #define ODM_REG_PIN_CTRL_11N 0x870
-#define ODM_REG_BB_PWR_SAV1_11N 0x874
-#define ODM_REG_ANTSEL_PATH_11N 0x878
-#define ODM_REG_BB_3WIRE_11N 0x88C
 #define ODM_REG_SC_CNT_11N 0x8C4
-#define ODM_REG_PSD_DATA_11N 0x8B4
-#define ODM_REG_CCX_PERIOD_11N 0x894
-#define ODM_REG_NHM_TH9_TH10_11N 0x890
-#define ODM_REG_CLM_11N 0x890
-#define ODM_REG_NHM_TH3_TO_TH0_11N 0x898
-#define ODM_REG_NHM_TH7_TO_TH4_11N 0x89c
-#define ODM_REG_NHM_TH8_11N 0xe28
-#define ODM_REG_CLM_READY_11N 0x8b4
-#define ODM_REG_CLM_RESULT_11N 0x8d0
-#define ODM_REG_NHM_CNT_11N 0x8d8
-
-/* For struct acs_info, Jeffery, 2014-12-26 */
-#define ODM_REG_NHM_CNT7_TO_CNT4_11N 0x8dc
-#define ODM_REG_NHM_CNT9_TO_CNT8_11N 0x8d0
-#define ODM_REG_NHM_CNT10_TO_CNT11_11N 0x8d4
 
-/* PAGE 9 */
-#define ODM_REG_BB_CTRL_PAGE9_11N 0x900
-#define ODM_REG_DBG_RPT_11N 0x908
-#define ODM_REG_BB_TX_PATH_11N 0x90c
 #define ODM_REG_ANT_MAPPING1_11N 0x914
-#define ODM_REG_ANT_MAPPING2_11N 0x918
-#define ODM_REG_EDCCA_DOWN_OPT_11N 0x948
-#define ODM_REG_RX_DFIR_MOD_97F 0x948
 
-/* PAGE A */
 #define ODM_REG_CCK_ANTDIV_PARA1_11N 0xA00
-#define ODM_REG_CCK_ANT_SEL_11N 0xA04
 #define ODM_REG_CCK_CCA_11N 0xA0A
 #define ODM_REG_CCK_ANTDIV_PARA2_11N 0xA0C
-#define ODM_REG_CCK_ANTDIV_PARA3_11N 0xA10
-#define ODM_REG_CCK_ANTDIV_PARA4_11N 0xA14
-#define ODM_REG_CCK_FILTER_PARA1_11N 0xA22
-#define ODM_REG_CCK_FILTER_PARA2_11N 0xA23
-#define ODM_REG_CCK_FILTER_PARA3_11N 0xA24
-#define ODM_REG_CCK_FILTER_PARA4_11N 0xA25
-#define ODM_REG_CCK_FILTER_PARA5_11N 0xA26
-#define ODM_REG_CCK_FILTER_PARA6_11N 0xA27
-#define ODM_REG_CCK_FILTER_PARA7_11N 0xA28
-#define ODM_REG_CCK_FILTER_PARA8_11N 0xA29
 #define ODM_REG_CCK_FA_RST_11N 0xA2C
 #define ODM_REG_CCK_FA_MSB_11N 0xA58
 #define ODM_REG_CCK_FA_LSB_11N 0xA5C
 #define ODM_REG_CCK_CCA_CNT_11N 0xA60
 #define ODM_REG_BB_PWR_SAV4_11N 0xA74
-/* PAGE B */
+
 #define ODM_REG_LNA_SWITCH_11N 0xB2C
-#define ODM_REG_PATH_SWITCH_11N 0xB30
-#define ODM_REG_RSSI_CTRL_11N 0xB38
-#define ODM_REG_CONFIG_ANTA_11N 0xB68
-#define ODM_REG_RSSI_BT_11N 0xB9C
-#define ODM_REG_RXCK_RFMOD 0xBB0
-#define ODM_REG_EDCCA_DCNF_97F 0xBC0
 
-/* PAGE C */
 #define ODM_REG_OFDM_FA_HOLDC_11N 0xC00
-#define ODM_REG_BB_RX_PATH_11N 0xC04
-#define ODM_REG_TRMUX_11N 0xC08
-#define ODM_REG_OFDM_FA_RSTC_11N 0xC0C
-#define ODM_REG_DOWNSAM_FACTOR_11N 0xC10
-#define ODM_REG_RXIQI_MATRIX_11N 0xC14
-#define ODM_REG_TXIQK_MATRIX_LSB1_11N 0xC4C
 #define ODM_REG_IGI_A_11N 0xC50
-#define ODM_REG_ANTDIV_PARA2_11N 0xC54
-#define ODM_REG_IGI_B_11N 0xC58
-#define ODM_REG_ANTDIV_PARA3_11N 0xC5C
-#define ODM_REG_L1SBD_PD_CH_11N 0XC6C
-#define ODM_REG_BB_PWR_SAV2_11N 0xC70
-#define ODM_REG_BB_AGC_SET_2_11N 0xc74
-#define ODM_REG_RX_OFF_11N 0xC7C
-#define ODM_REG_TXIQK_MATRIXA_11N 0xC80
-#define ODM_REG_TXIQK_MATRIXB_11N 0xC88
-#define ODM_REG_TXIQK_MATRIXA_LSB2_11N 0xC94
-#define ODM_REG_TXIQK_MATRIXB_LSB2_11N 0xC9C
-#define ODM_REG_RXIQK_MATRIX_LSB_11N 0xCA0
 #define ODM_REG_ANTDIV_PARA1_11N 0xCA4
-#define ODM_REG_SMALL_BANDWIDTH_11N 0xCE4
 #define ODM_REG_OFDM_FA_TYPE1_11N 0xCF0
-/* PAGE D */
+
 #define ODM_REG_OFDM_FA_RSTD_11N 0xD00
-#define ODM_REG_BB_RX_ANT_11N 0xD04
-#define ODM_REG_BB_ATC_11N 0xD2C
 #define ODM_REG_OFDM_FA_TYPE2_11N 0xDA0
 #define ODM_REG_OFDM_FA_TYPE3_11N 0xDA4
 #define ODM_REG_OFDM_FA_TYPE4_11N 0xDA8
-#define ODM_REG_RPT_11N 0xDF4
-/* PAGE E */
-#define ODM_REG_TXAGC_A_6_18_11N 0xE00
-#define ODM_REG_TXAGC_A_24_54_11N 0xE04
-#define ODM_REG_TXAGC_A_1_MCS32_11N 0xE08
-#define ODM_REG_TXAGC_A_MCS0_3_11N 0xE10
-#define ODM_REG_TXAGC_A_MCS4_7_11N 0xE14
-#define ODM_REG_TXAGC_A_MCS8_11_11N 0xE18
-#define ODM_REG_TXAGC_A_MCS12_15_11N 0xE1C
-#define ODM_REG_EDCCA_DCNF_11N 0xE24
-#define ODM_REG_TAP_UPD_97F 0xE24
-#define ODM_REG_FPGA0_IQK_11N 0xE28
-#define ODM_REG_PAGE_B1_97F 0xE28
-#define ODM_REG_TXIQK_TONE_A_11N 0xE30
-#define ODM_REG_RXIQK_TONE_A_11N 0xE34
-#define ODM_REG_TXIQK_PI_A_11N 0xE38
-#define ODM_REG_RXIQK_PI_A_11N 0xE3C
-#define ODM_REG_TXIQK_11N 0xE40
-#define ODM_REG_RXIQK_11N 0xE44
-#define ODM_REG_IQK_AGC_PTS_11N 0xE48
-#define ODM_REG_IQK_AGC_RSP_11N 0xE4C
-#define ODM_REG_BLUETOOTH_11N 0xE6C
-#define ODM_REG_RX_WAIT_CCA_11N 0xE70
-#define ODM_REG_TX_CCK_RFON_11N 0xE74
-#define ODM_REG_TX_CCK_BBON_11N 0xE78
-#define ODM_REG_OFDM_RFON_11N 0xE7C
-#define ODM_REG_OFDM_BBON_11N 0xE80
-#define ODM_REG_TX2RX_11N 0xE84
-#define ODM_REG_TX2TX_11N 0xE88
-#define ODM_REG_RX_CCK_11N 0xE8C
-#define ODM_REG_RX_OFDM_11N 0xED0
-#define ODM_REG_RX_WAIT_RIFS_11N 0xED4
-#define ODM_REG_RX2RX_11N 0xED8
-#define ODM_REG_STANDBY_11N 0xEDC
-#define ODM_REG_SLEEP_11N 0xEE0
-#define ODM_REG_PMPD_ANAEN_11N 0xEEC
-/* PAGE F */
-#define ODM_REG_PAGE_F_RST_11N 0xF14
-#define ODM_REG_IGI_C_11N 0xF84
-#define ODM_REG_IGI_D_11N 0xF88
-#define ODM_REG_CCK_CRC32_ERROR_CNT_11N 0xF84
-#define ODM_REG_CCK_CRC32_OK_CNT_11N 0xF88
-#define ODM_REG_HT_CRC32_CNT_11N 0xF90
-#define ODM_REG_OFDM_CRC32_CNT_11N 0xF94
 
-/* 2 MAC REG LIST */
-#define ODM_REG_BB_RST_11N 0x02
 #define ODM_REG_ANTSEL_PIN_11N 0x4C
-#define ODM_REG_EARLY_MODE_11N 0x4D0
-#define ODM_REG_RSSI_MONITOR_11N 0x4FE
-#define ODM_REG_EDCA_VO_11N 0x500
-#define ODM_REG_EDCA_VI_11N 0x504
-#define ODM_REG_EDCA_BE_11N 0x508
-#define ODM_REG_EDCA_BK_11N 0x50C
-#define ODM_REG_TXPAUSE_11N 0x522
 #define ODM_REG_RESP_TX_11N 0x6D8
-#define ODM_REG_ANT_TRAIN_PARA1_11N 0x7b0
-#define ODM_REG_ANT_TRAIN_PARA2_11N 0x7b4
 
-/* DIG Related */
 #define ODM_BIT_IGI_11N 0x0000007F
-#define ODM_BIT_CCK_RPT_FORMAT_11N BIT(9)
-#define ODM_BIT_BB_RX_PATH_11N 0xF
-#define ODM_BIT_BB_TX_PATH_11N 0xF
-#define ODM_BIT_BB_ATC_11N BIT(11)
 
 #endif
-- 
2.21.0


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0002-staging-rtlwifi-move-remaining-phydm-.h-files.patch"

From adc7af464ceba1962c2eb875a97f4d3bd82fbc5f Mon Sep 17 00:00:00 2001
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Wed, 1 May 2019 10:40:10 +0200
Subject: [PATCH 2/2] staging: rtlwifi: move remaining phydm .h files

The rtl8188eu driver uses the phydm .h files from the rtlwifi driver,
but now that the rtlwifi driver is gone, it's silly to have a whole
directory for just 2 .h files.  So move these files into the rtl8188eu
driver's directory so that it can be self-contained.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/rtl8188eu/include/odm_precomp.h               | 4 ++--
 .../staging/{rtlwifi/phydm => rtl8188eu/include}/phydm_reg.h  | 0
 .../{rtlwifi/phydm => rtl8188eu/include}/phydm_regdefine11n.h | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename drivers/staging/{rtlwifi/phydm => rtl8188eu/include}/phydm_reg.h (100%)
 rename drivers/staging/{rtlwifi/phydm => rtl8188eu/include}/phydm_regdefine11n.h (100%)

diff --git a/drivers/staging/rtl8188eu/include/odm_precomp.h b/drivers/staging/rtl8188eu/include/odm_precomp.h
index 6efddc8f1675..df096c37f5eb 100644
--- a/drivers/staging/rtl8188eu/include/odm_precomp.h
+++ b/drivers/staging/rtl8188eu/include/odm_precomp.h
@@ -24,12 +24,12 @@
 #include "odm.h"
 #include "odm_hwconfig.h"
 #include "odm_debug.h"
-#include "../../rtlwifi/phydm/phydm_regdefine11n.h"
+#include "phydm_regdefine11n.h"
 
 #include "hal8188e_rate_adaptive.h" /* for RA,Power training */
 #include "rtl8188e_hal.h"
 
-#include "../../rtlwifi/phydm/phydm_reg.h"
+#include "phydm_reg.h"
 
 #include "odm_rtl8188e.h"
 
diff --git a/drivers/staging/rtlwifi/phydm/phydm_reg.h b/drivers/staging/rtl8188eu/include/phydm_reg.h
similarity index 100%
rename from drivers/staging/rtlwifi/phydm/phydm_reg.h
rename to drivers/staging/rtl8188eu/include/phydm_reg.h
diff --git a/drivers/staging/rtlwifi/phydm/phydm_regdefine11n.h b/drivers/staging/rtl8188eu/include/phydm_regdefine11n.h
similarity index 100%
rename from drivers/staging/rtlwifi/phydm/phydm_regdefine11n.h
rename to drivers/staging/rtl8188eu/include/phydm_regdefine11n.h
-- 
2.21.0


--AqsLC8rIMeq19msA--
