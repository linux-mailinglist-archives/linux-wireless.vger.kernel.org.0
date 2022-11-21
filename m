Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5206E6327E5
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Nov 2022 16:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbiKUPZj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Nov 2022 10:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbiKUPZO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Nov 2022 10:25:14 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF17BF71
        for <linux-wireless@vger.kernel.org>; Mon, 21 Nov 2022 07:25:13 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id l39-20020a05600c1d2700b003cf93c8156dso9248575wms.4
        for <linux-wireless@vger.kernel.org>; Mon, 21 Nov 2022 07:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QhOifESU8EdFJ+rIuKq3ZrqQCo1csqnKAHKDn8/mvqc=;
        b=D9jYBe99uGWYCGqSAD9NNjXTzfUj57GquZQRrhqDGjrrwzK/9FbXIvvldzrn8CciNo
         ia6jdq3IEgeC2GT6eBjr7614zyIPllzon2QqCYngvccvAWFYq+Zb6TqZU/eBJJHrHgxz
         t+eoIHZiEJpPdF46tOA7b/FflLuijnSRIRPiJb9RNRIxQw2Kjz27E1yyPUSt6FiIqNx1
         oYu1JKLYXAlgBogClUYFOv97O1f8Lody3YCt+J3YCUN565vEWbP4azwd6xF7Sfr+X7Gt
         vBdxso8qwplqJXktMlYK4KzFVryFA/kLyLrBEKecMP3rSTKNeIgK2NsHytcPOBRoK8tM
         fomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QhOifESU8EdFJ+rIuKq3ZrqQCo1csqnKAHKDn8/mvqc=;
        b=fA3upVtzYXNIkBKYc7FHnRSEs+t0GaObDAUh0BMpfFMZGpFNJ//dkV80f+l62RAUUf
         wI2W4JI/CHrvUyUr7i/0RuIqmSI7TiWQRSam7WLxXeWPBKEmj3F1rmnZGy0lcwW7Xhh9
         WE6efE3nawN3rGTFSMYD1TaNqN5gybHtsb3FX7JCWBJYdXvHuruSx5rOdSUfu19CYSJT
         NQNR8Fb4f1NlaGVr8m3NYQFPSIhJvSXKBPEKfnKx3qyrVCJojDJ806RTu7eWtRLul/kD
         zLJZOoRAEDlzWqhl6WBXVzKig3zEEETVPa2XFlnZBUW/1sGpYzzD45CH8d4UZ4JBU7aH
         4dDA==
X-Gm-Message-State: ANoB5pkPs5t3n79v9y7cFrcsJA1AEiQHqaO3j8EgSjoN6YoeWHgoVD87
        AuFJHNtcrpl9eeakQIQHnu4=
X-Google-Smtp-Source: AA0mqf7ANdepIoXp3H7Jj0YzWfNz+B5z28T090yr6/J6C7BJaPqiyJVE87fXzk3pEzSeNyf732EtJQ==
X-Received: by 2002:a05:600c:1e1a:b0:3cf:7959:d8be with SMTP id ay26-20020a05600c1e1a00b003cf7959d8bemr4991356wmb.85.1669044311717;
        Mon, 21 Nov 2022 07:25:11 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id 4-20020a05600c020400b003b492753826sm13640907wmi.43.2022.11.21.07.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 07:25:11 -0800 (PST)
Date:   Mon, 21 Nov 2022 18:25:04 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     avraham.stern@intel.com
Cc:     linux-wireless@vger.kernel.org
Subject: [bug report] wifi: iwlwifi: mei: implement PLDR flow
Message-ID: <Y3uYUEFnMiBY2ABQ@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Avraham Stern,

The patch 733eb54f62c6: "wifi: iwlwifi: mei: implement PLDR flow"
from Nov 2, 2022, leads to the following unpublished Smatch static
checker warning:

drivers/net/wireless/intel/iwlwifi/mvm/fw.c:407 iwl_mvm_load_ucode_wait_alive() warn: duplicate check 'ret' (previous on line 357)
drivers/net/wireless/intel/iwlwifi/mvm/fw.c:1471 iwl_mvm_up() warn: missing error code? 'ret'

drivers/net/wireless/intel/iwlwifi/mvm/fw.c
    311 static int iwl_mvm_load_ucode_wait_alive(struct iwl_mvm *mvm,
    312                                          enum iwl_ucode_type ucode_type)
    313 {
    314         struct iwl_notification_wait alive_wait;
    315         struct iwl_mvm_alive_data alive_data = {};
    316         const struct fw_img *fw;
    317         int ret;
    318         enum iwl_ucode_type old_type = mvm->fwrt.cur_fw_img;
    319         static const u16 alive_cmd[] = { UCODE_ALIVE_NTFY };
    320         bool run_in_rfkill =
    321                 ucode_type == IWL_UCODE_INIT || iwl_mvm_has_unified_ucode(mvm);
    322 
    323         if (ucode_type == IWL_UCODE_REGULAR &&
    324             iwl_fw_dbg_conf_usniffer(mvm->fw, FW_DBG_START_FROM_ALIVE) &&
    325             !(fw_has_capa(&mvm->fw->ucode_capa,
    326                           IWL_UCODE_TLV_CAPA_USNIFFER_UNIFIED)))
    327                 fw = iwl_get_ucode_image(mvm->fw, IWL_UCODE_REGULAR_USNIFFER);
    328         else
    329                 fw = iwl_get_ucode_image(mvm->fw, ucode_type);
    330         if (WARN_ON(!fw))
    331                 return -EINVAL;
    332         iwl_fw_set_current_image(&mvm->fwrt, ucode_type);
    333         clear_bit(IWL_MVM_STATUS_FIRMWARE_RUNNING, &mvm->status);
    334 
    335         iwl_init_notification_wait(&mvm->notif_wait, &alive_wait,
    336                                    alive_cmd, ARRAY_SIZE(alive_cmd),
    337                                    iwl_alive_fn, &alive_data);
    338 
    339         /*
    340          * We want to load the INIT firmware even in RFKILL
    341          * For the unified firmware case, the ucode_type is not
    342          * INIT, but we still need to run it.
    343          */
    344         ret = iwl_trans_start_fw(mvm->trans, fw, run_in_rfkill);
    345         if (ret) {
    346                 iwl_fw_set_current_image(&mvm->fwrt, old_type);
    347                 iwl_remove_notification(&mvm->notif_wait, &alive_wait);
    348                 return ret;
    349         }
    350 
    351         /*
    352          * Some things may run in the background now, but we
    353          * just wait for the ALIVE notification here.
    354          */
    355         ret = iwl_wait_notification(&mvm->notif_wait, &alive_wait,
    356                                     MVM_UCODE_ALIVE_TIMEOUT);
    357         if (ret) {
    358                 struct iwl_trans *trans = mvm->trans;
    359 
    360                 /* SecBoot info */
    361                 if (trans->trans_cfg->device_family >=
    362                                         IWL_DEVICE_FAMILY_22000) {
    363                         IWL_ERR(mvm,
    364                                 "SecBoot CPU1 Status: 0x%x, CPU2 Status: 0x%x\n",
    365                                 iwl_read_umac_prph(trans, UMAG_SB_CPU_1_STATUS),
    366                                 iwl_read_umac_prph(trans,
    367                                                    UMAG_SB_CPU_2_STATUS));
    368                 } else if (trans->trans_cfg->device_family >=
    369                            IWL_DEVICE_FAMILY_8000) {
    370                         IWL_ERR(mvm,
    371                                 "SecBoot CPU1 Status: 0x%x, CPU2 Status: 0x%x\n",
    372                                 iwl_read_prph(trans, SB_CPU_1_STATUS),
    373                                 iwl_read_prph(trans, SB_CPU_2_STATUS));
    374                 }
    375 
    376                 iwl_mvm_print_pd_notification(mvm);
    377 
    378                 /* LMAC/UMAC PC info */
    379                 if (trans->trans_cfg->device_family >=
    380                                         IWL_DEVICE_FAMILY_9000) {
    381                         IWL_ERR(mvm, "UMAC PC: 0x%x\n",
    382                                 iwl_read_umac_prph(trans,
    383                                                    UREG_UMAC_CURRENT_PC));
    384                         IWL_ERR(mvm, "LMAC PC: 0x%x\n",
    385                                 iwl_read_umac_prph(trans,
    386                                                    UREG_LMAC1_CURRENT_PC));
    387                         if (iwl_mvm_is_cdb_supported(mvm))
    388                                 IWL_ERR(mvm, "LMAC2 PC: 0x%x\n",
    389                                         iwl_read_umac_prph(trans,
    390                                                 UREG_LMAC2_CURRENT_PC));
    391                 }
    392 
    393                 if (ret == -ETIMEDOUT)
    394                         iwl_fw_dbg_error_collect(&mvm->fwrt,
    395                                                  FW_DBG_TRIGGER_ALIVE_TIMEOUT);
    396 
    397                 iwl_fw_set_current_image(&mvm->fwrt, old_type);
    398                 return ret;
                        ^^^^^^^^^^^

    399         }
    400 
    401         if (!alive_data.valid) {
    402                 IWL_ERR(mvm, "Loaded ucode is not valid!\n");
    403                 iwl_fw_set_current_image(&mvm->fwrt, old_type);
    404                 return -EIO;
    405         }
    406 
--> 407         iwl_mei_alive_notif(!ret);

We know that "ret" is zero.

    408 
    409         ret = iwl_pnvm_load(mvm->trans, &mvm->notif_wait);
    410         if (ret) {

[ snip ]

  1455  int iwl_mvm_up(struct iwl_mvm *mvm)
  1456  {
  1457          int ret, i;
  1458          struct ieee80211_channel *chan;
  1459          struct cfg80211_chan_def chandef;
  1460          struct ieee80211_supported_band *sband = NULL;
  1461          u32 sb_cfg;
  1462  
  1463          lockdep_assert_held(&mvm->mutex);
  1464  
  1465          ret = iwl_trans_start_hw(mvm->trans);
  1466          if (ret)
  1467                  return ret;
  1468  
  1469          sb_cfg = iwl_read_umac_prph(mvm->trans, SB_MODIFY_CFG_FLAG);
  1470          if (!(sb_cfg & SB_CFG_RESIDES_IN_OTP_MASK) && iwl_mei_pldr_req())
  1471                  return ret;

Probably return -EINVAL was intended.  (This code actually inspired me
to create this static checker warning.  ;) So it hasn't been tested yet.
Will test tonight.  Gotta run though...)

  1472  
  1473          ret = iwl_mvm_load_rt_fw(mvm);
  1474          if (ret) {

regards,
dan carpenter
