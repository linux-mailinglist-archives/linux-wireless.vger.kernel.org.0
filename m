Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51C7E120018
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2019 09:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfLPIoG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Dec 2019 03:44:06 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:46102 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfLPIoF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Dec 2019 03:44:05 -0500
Received: by mail-qv1-f66.google.com with SMTP id t9so2387121qvh.13
        for <linux-wireless@vger.kernel.org>; Mon, 16 Dec 2019 00:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2TdJGIWRjtrpiZuH5yQi/H5WCXhgNXZWIgPqQo+Pwjs=;
        b=Vy45OaE1VWXXJpZRj5LF7eLWxegqAprQD4kxSJ3ILwfRw/yaUhV40y1+boNLW24EnR
         i0uiEVYLj+b9CL/La2IcsVCWALJAjUUxttu1gvbLa8zW+RF0KGLca3zaggKtA7mHrY8B
         fwiQ7KjaG3elMvBj7fyELs2LhF/WL0cBmKHcuWs0o4YENCdsVqHzjRuK7JUrxNFh6nTe
         4450tsD271/4VjdCi19miS+BYVVtWuXTJFhuzyafJlIsjHjw9yq3ZZ7EW5uJfAYqyPTY
         wUfO0YAVKIWt/mGr3eLHrST0PKukvdbPs0brHOy9zUzHOMhSqwhfkTXGSOjXR2Xx9xXm
         GgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2TdJGIWRjtrpiZuH5yQi/H5WCXhgNXZWIgPqQo+Pwjs=;
        b=AGBpKo5U8DkGs7MqrzmeoU6YKT7BHjOIXgqHUHOINIg6uF1isGmSgz78kuiadfmV8s
         iTIlsC4OZzpCj4dlKpqqK28SBnLBm7T2EXvyr7hKtXPh/jXvZKxH1AC6wypcx42e7u2Y
         iAA5xxz9D+UcZMtMD+IH5BL5tocXuFak/dY3uhrCBxZ5Z7MAkpOwdiiXWqLxpTudUfgZ
         OeVbCBzGyfv2so8Rkl2uSpwctW6sULPUncumBkwKM0+OTUcpbAdT4GpdfE9j2LpIUahk
         cW8+vfBsqTlTm/U+Qszvk4sIQqyjqwsEEsGo8RT+yKItAQoPBZQp7TGkqGmrzOO1PrfD
         5FMA==
X-Gm-Message-State: APjAAAVxLjUshB2xqWw2As/4lpkcq67pXwsRjwjUC0J65ZeP/0YJUcOF
        gB8ilsa9espcl04UfNqAu2MgmnZCOriCMc0FR24xm9/fHyiG+g==
X-Google-Smtp-Source: APXvYqyYL1L8pZxRzEjHnJ7qydVbmvChCoTPDycJrweTjS+aRAtSCoyHFmPi+FYWvOX1OTzHpxTVJrJdBvjHCeBGP6Y=
X-Received: by 2002:a0c:9ad6:: with SMTP id k22mr24717829qvf.154.1576485844427;
 Mon, 16 Dec 2019 00:44:04 -0800 (PST)
MIME-Version: 1.0
References: <20191209072139.26068-1-yhchuang@realtek.com> <20191209072139.26068-5-yhchuang@realtek.com>
In-Reply-To: <20191209072139.26068-5-yhchuang@realtek.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Mon, 16 Dec 2019 16:45:09 +0800
Message-ID: <CAB4CAwdGJPNJRPfsvCKEGLqFGfQT2eBWXY3YCxSWJkN-1NwGrA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] rtw88: support wowlan feature for 8822c
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Dec 9, 2019 at 3:21 PM <yhchuang@realtek.com> wrote:
>
> From: Chin-Yen Lee <timlee@realtek.com>
>
> Wake on WLAN(wowlan) is a feature which allows devices
> to be woken up from suspend state through wlan events.
>
> When user enables wowlan feature and then let the device
> enter suspend state, wowlan firmware will be loaded by
> the driver and periodically monitors wifi packets.
> Power consumption of wifi chip will be reduced in this
> state.
>
> If wowlan firmware detects that specific wlan event
> happens, it will issue wakeup signal to trigger resume
> process. Driver will load normal firmware and let wifi
> chip return to the original state.
>
> Currently supported wlan events include receiving magic packet,
> rekey packet and deauth packet, and disconnecting from AP.
>
> Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> ---
>
> v1 -> v2
>  * no change
>
> diff --git a/drivers/net/wireless/realtek/rtw88/wow.c b/drivers/net/wireless/realtek/rtw88/wow.c
> new file mode 100644
> index 000000000000..e1657d3cb615
> --- /dev/null
> +++ b/drivers/net/wireless/realtek/rtw88/wow.c
> @@ -0,0 +1,531 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> +/* Copyright(c) 2018-2019  Realtek Corporation
> + */
> +
> +#include "main.h"
> +#include "fw.h"
> +#include "wow.h"
> +#include "reg.h"
> +#include "debug.h"
> +#include "mac.h"
> +#include "ps.h"
> +
> +static void rtw_wow_show_wakeup_reason(struct rtw_dev *rtwdev)
> +{
> +       u8 reason;
> +
> +       reason = rtw_read8(rtwdev, REG_WOWLAN_WAKE_REASON);
> +
> +       if (reason == RTW_WOW_RSN_RX_DEAUTH)
> +               rtw_dbg(rtwdev, RTW_DBG_WOW, "WOW: Rx deauth\n");
> +       else if (reason == RTW_WOW_RSN_DISCONNECT)
> +               rtw_dbg(rtwdev, RTW_DBG_WOW, "WOW: AP is off\n");
> +       else if (reason == RTW_WOW_RSN_RX_MAGIC_PKT)
> +               rtw_dbg(rtwdev, RTW_DBG_WOW, "WOW: Rx magic packet\n");
> +       else if (reason == RTW_WOW_RSN_RX_GTK_REKEY)
> +               rtw_dbg(rtwdev, RTW_DBG_WOW, "WOW: Rx gtk rekey\n");
> +       else if (reason == RTW_WOW_RSN_RX_PTK_REKEY)
> +               rtw_dbg(rtwdev, RTW_DBG_WOW, "WOW: Rx ptk rekey\n");
> +       else
> +               rtw_warn(rtwdev, "Unknown wakeup reason %x\n", reason);
> +}
> +
> +static void rtw_wow_bb_stop(struct rtw_dev *rtwdev)
> +{
> +       struct rtw_wow_param *rtw_wow = &rtwdev->wow;
> +
> +       /* wait 100ms for firmware to finish TX */
> +       msleep(100);
> +
> +       if (!rtw_read32_mask(rtwdev, REG_BCNQ_INFO, BIT_MGQ_CPU_EMPTY))
> +               rtw_warn(rtwdev, "Wrong status of MGQ_CPU empty!\n");
> +
> +       rtw_wow->txpause = rtw_read8(rtwdev, REG_TXPAUSE);
> +       rtw_write8(rtwdev, REG_TXPAUSE, 0xff);
> +       rtw_write8_clr(rtwdev, REG_SYS_FUNC_EN, BIT_FEN_BB_RSTB);
> +}
> +
> +static void rtw_wow_bb_start(struct rtw_dev *rtwdev)
> +{
> +       struct rtw_wow_param *rtw_wow = &rtwdev->wow;
> +
> +       rtw_write8_set(rtwdev, REG_SYS_FUNC_EN, BIT_FEN_BB_RSTB);
> +       rtw_write8(rtwdev, REG_TXPAUSE, rtw_wow->txpause);
> +}
> +
> +static void rtw_wow_rx_dma_stop(struct rtw_dev *rtwdev)
> +{
> +       /* wait 100ms for HW to finish rx dma */
> +       msleep(100);
> +
> +       rtw_write32_set(rtwdev, REG_RXPKT_NUM, BIT_RW_RELEASE);
> +
> +       if (!check_hw_ready(rtwdev, REG_RXPKT_NUM, BIT_RXDMA_IDLE, 1))
> +               rtw_err(rtwdev, "failed to stop rx dma\n");
> +}
> +
> +static void rtw_wow_rx_dma_start(struct rtw_dev *rtwdev)
> +{
> +       rtw_write32_clr(rtwdev, REG_RXPKT_NUM, BIT_RW_RELEASE);
> +}
> +
> +static bool rtw_wow_check_fw_status(struct rtw_dev *rtwdev, bool wow_enable)
> +{
> +       bool ret;
> +
> +       /* wait 100ms for wow firmware to finish work */
> +       msleep(100);
> +
> +       if (wow_enable) {
> +               if (!rtw_read8(rtwdev, REG_WOWLAN_WAKE_REASON))
> +                       ret = 0;
> +       } else {
> +               if (rtw_read32_mask(rtwdev, REG_FE1IMR, BIT_FS_RXDONE) == 0 &&
> +                   rtw_read32_mask(rtwdev, REG_RXPKT_NUM, BIT_RW_RELEASE) == 0)
> +                       ret = 0;
> +       }
> +
> +       if (ret)
> +               rtw_err(rtwdev, "failed to check wow status %s\n",
> +                       wow_enable ? "enabled" : "disabled");
> +
> +       return ret;
> +}
> +
> +static void rtw_wow_fw_security_type_iter(struct ieee80211_hw *hw,
> +                                         struct ieee80211_vif *vif,
> +                                         struct ieee80211_sta *sta,
> +                                         struct ieee80211_key_conf *key,
> +                                         void *data)
> +{
> +       struct rtw_fw_key_type_iter_data *iter_data = data;
> +       struct rtw_dev *rtwdev = hw->priv;
> +       u8 hw_key_type;
> +
> +       if (vif != rtwdev->wow.wow_vif)
> +               return;
> +
> +       switch (key->cipher) {
> +       case WLAN_CIPHER_SUITE_WEP40:
> +               hw_key_type = RTW_CAM_WEP40;
> +               break;
> +       case WLAN_CIPHER_SUITE_WEP104:
> +               hw_key_type = RTW_CAM_WEP104;
> +               break;
> +       case WLAN_CIPHER_SUITE_TKIP:
> +               hw_key_type = RTW_CAM_TKIP;
> +               key->flags |= IEEE80211_KEY_FLAG_GENERATE_MMIC;
> +               break;
> +       case WLAN_CIPHER_SUITE_CCMP:
> +               hw_key_type = RTW_CAM_AES;
> +               key->flags |= IEEE80211_KEY_FLAG_SW_MGMT_TX;
> +               break;
> +       default:
> +               rtw_err(rtwdev, "Unsupported key type for wowlan mode\n");
> +               hw_key_type = 0;
> +               break;
> +       }
> +
> +       if (sta)
> +               iter_data->pairwise_key_type = hw_key_type;
> +       else
> +               iter_data->group_key_type = hw_key_type;
> +}
> +
> +static void rtw_wow_fw_security_type(struct rtw_dev *rtwdev)
> +{
> +       struct rtw_fw_key_type_iter_data data = {};
> +       struct ieee80211_vif *wow_vif = rtwdev->wow.wow_vif;
> +
> +       data.rtwdev = rtwdev;
> +       rtw_iterate_keys(rtwdev, wow_vif,
> +                        rtw_wow_fw_security_type_iter, &data);
> +       rtw_fw_set_aoac_global_info_cmd(rtwdev, data.pairwise_key_type,
> +                                       data.group_key_type);
> +}
> +
> +static int rtw_wow_fw_start(struct rtw_dev *rtwdev)
> +{
> +       if (rtw_wow_mgd_linked(rtwdev)) {
> +               rtw_send_rsvd_page_h2c(rtwdev);
> +               rtw_wow_fw_security_type(rtwdev);
> +               rtw_fw_set_disconnect_decision_cmd(rtwdev, true);
> +               rtw_fw_set_keep_alive_cmd(rtwdev, true);
> +       }
> +
> +       rtw_fw_set_wowlan_ctrl_cmd(rtwdev, true);
> +       rtw_fw_set_remote_wake_ctrl_cmd(rtwdev, true);
> +
> +       return rtw_wow_check_fw_status(rtwdev, true);
> +}
> +
> +static int rtw_wow_fw_stop(struct rtw_dev *rtwdev)
> +{
> +       if (rtw_wow_mgd_linked(rtwdev)) {
> +               rtw_fw_set_disconnect_decision_cmd(rtwdev, false);
> +               rtw_fw_set_keep_alive_cmd(rtwdev, false);
> +       }
> +
> +       rtw_fw_set_wowlan_ctrl_cmd(rtwdev, false);
> +       rtw_fw_set_remote_wake_ctrl_cmd(rtwdev, false);
> +
> +       return rtw_wow_check_fw_status(rtwdev, false);
> +}
> +
> +static void rtw_wow_avoid_reset_mac(struct rtw_dev *rtwdev)
> +{
> +       /* When resuming from wowlan mode, some hosts issue signal
> +        * (PCIE: PREST, USB: SE0RST) to device, and lead to reset
> +        * mac core. If it happens, the connection to AP will be lost.
> +        * Setting REG_RSV_CTRL Register can avoid this process.
> +        */
> +       switch (rtw_hci_type(rtwdev)) {
> +       case RTW_HCI_TYPE_PCIE:
> +       case RTW_HCI_TYPE_USB:
> +               rtw_write8(rtwdev, REG_RSV_CTRL, BIT_WLOCK_1C_B6);
> +               rtw_write8(rtwdev, REG_RSV_CTRL,
> +                          BIT_WLOCK_1C_B6 | BIT_R_DIS_PRST);
> +               break;
> +       default:
> +               rtw_warn(rtwdev, "Unsupported hci type to disable reset MAC\n");
> +               break;
> +       }
> +}
> +
> +static void rtw_wow_fw_media_status_iter(void *data, struct ieee80211_sta *sta)
> +{
> +       struct rtw_sta_info *si = (struct rtw_sta_info *)sta->drv_priv;
> +       struct rtw_fw_media_status_iter_data *iter_data = data;
> +       struct rtw_dev *rtwdev = iter_data->rtwdev;
> +
> +       rtw_fw_media_status_report(rtwdev, si->mac_id, iter_data->connect);
> +}
> +
> +static void rtw_wow_fw_media_status(struct rtw_dev *rtwdev, bool connect)
> +{
> +       struct rtw_fw_media_status_iter_data data;
> +
> +       data.rtwdev = rtwdev;
> +       data.connect = connect;
> +
> +       rtw_iterate_stas_atomic(rtwdev, rtw_wow_fw_media_status_iter, &data);
> +}
> +
> +void __rtw_wow_config_linked_rsvd_page(struct rtw_dev *rtwdev)
> +{
> +       rtw_add_rsvd_page(rtwdev, RSVD_PS_POLL, true);
> +       rtw_add_rsvd_page(rtwdev, RSVD_QOS_NULL, true);
> +       rtw_add_rsvd_page(rtwdev, RSVD_NULL, true);
> +       rtw_add_rsvd_page(rtwdev, RSVD_LPS_PG_DPK, true);
> +       rtw_add_rsvd_page(rtwdev, RSVD_LPS_PG_INFO, true);
> +}
> +
> +static void rtw_wow_config_rsvd_page(struct rtw_dev *rtwdev)
> +{
> +       rtw_reset_rsvd_page(rtwdev);
> +
> +       if (rtw_wow_mgd_linked(rtwdev))
> +               __rtw_wow_config_linked_rsvd_page(rtwdev);
> +}
> +
> +static int rtw_wow_dl_fw_rsvd_page(struct rtw_dev *rtwdev)
> +{
> +       struct ieee80211_vif *wow_vif = rtwdev->wow.wow_vif;
> +
> +       rtw_wow_config_rsvd_page(rtwdev);
> +
> +       return rtw_fw_download_rsvd_page(rtwdev, wow_vif);
> +}
> +
> +static int rtw_wow_swap_fw(struct rtw_dev *rtwdev, enum rtw_fw_type type)
> +{
> +       struct rtw_fw_state *fw;
> +       int ret;
> +
> +       switch (type) {
> +       case RTW_WOWLAN_FW:
> +               fw = &rtwdev->wow_fw;
> +               break;
> +
> +       case RTW_NORMAL_FW:
> +               fw = &rtwdev->fw;
> +               break;
> +
> +       default:
> +               rtw_warn(rtwdev, "unsupported firmware type to swap\n");
> +               return -ENOENT;
> +       }
> +
> +       ret = rtw_download_firmware(rtwdev, fw);
> +       if (ret)
> +               goto out;
> +
> +       rtw_fw_send_general_info(rtwdev);
> +       rtw_fw_send_phydm_info(rtwdev);
> +       rtw_wow_fw_media_status(rtwdev, true);
> +
> +out:
> +       return ret;
> +}
> +
> +static int __rtw_wow_leave_linked_ps(struct rtw_dev *rtwdev)
> +{
> +       if (!test_bit(RTW_FLAG_WOWLAN, rtwdev->flags))
> +               cancel_delayed_work_sync(&rtwdev->watch_dog_work);
> +
> +       return 0;
> +}
> +
> +static int rtw_wow_leave_ps(struct rtw_dev *rtwdev)
> +{
> +       int ret = 0;
> +
> +       if (rtw_wow_mgd_linked(rtwdev))
> +               ret = __rtw_wow_leave_linked_ps(rtwdev);
> +
> +       return ret;
> +}
> +
> +static int __rtw_wow_enter_linked_ps(struct rtw_dev *rtwdev)
> +{
> +       struct rtw_wow_param *rtw_wow = &rtwdev->wow;
> +       struct ieee80211_vif *wow_vif = rtw_wow->wow_vif;
> +       struct rtw_vif *rtwvif = (struct rtw_vif *)wow_vif->drv_priv;
> +
> +       rtw_enter_lps(rtwdev, rtwvif->port);
> +
> +       return 0;
> +}
> +
> +static int rtw_wow_enter_ps(struct rtw_dev *rtwdev)
> +{
> +       int ret = 0;
> +
> +       if (rtw_wow_mgd_linked(rtwdev))
> +               ret = __rtw_wow_enter_linked_ps(rtwdev);
> +
> +       return ret;
> +}
> +

I don't like __underscore_means_inner_function(). The function
void __rtw_wow_config_linked_rsvd_page does not even prefix
with static. I strongly prefer function_has_a_proper_name() so please
come up with something that describes what it is really doing
and name it like that. The rest of the code looks OK to me.

> --
> 2.17.1
>
