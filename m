Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000B37D61D5
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Oct 2023 08:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjJYGvG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Oct 2023 02:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbjJYGvE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Oct 2023 02:51:04 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985341A1
        for <linux-wireless@vger.kernel.org>; Tue, 24 Oct 2023 23:51:00 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-32db188e254so3696001f8f.0
        for <linux-wireless@vger.kernel.org>; Tue, 24 Oct 2023 23:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698216659; x=1698821459; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tf0sCTSD0044PJIvH4hZHzZVoGo40XyncExnMBq4j5w=;
        b=GHrmTY9ehlLeOJZfZBpLkqvwN/r8bEbYfgOwimgvoQT+h6wRt4slJ4TsbLak2caTkA
         XkEe0tlCJEDsydc31WAouxXjGmVGWtHGx7SIMz8Kun4bdfieCVbhQMZ5DVHDKtDJ9ewM
         6fcqe7vAoiWW3hiaYHvBPXrwoaCohEUN3UrmqvEUzdzIeGV6rHsZ+ByzECsJXxjyVlX7
         IA9K+H2SuXRP8W02RnkUUg6vO2v9onDgLxuf/yyYBg0kWIGAM/Be/Ui67d0DqPuMBMPC
         AQoArBPqrlW4pS2+MAzQjwRogtaJ24VRuAmehjK7csBTt16LgmdZzHLc4YEU61jAzmL3
         WK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698216659; x=1698821459;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tf0sCTSD0044PJIvH4hZHzZVoGo40XyncExnMBq4j5w=;
        b=BZPkEID7+S3iSca+2RhQVIOzM2+J6hPcAACeV/JhbUFiHx7iBEoZoGJGwxBzu3YVIe
         i0XjkhSzApXYSm63rToiT+TBfF0C3RqARiIL9WRI4fAothRkiu4aXUTCPECmqjwMo3yI
         LUT2bMtoPmOv4Dca70GhRSHkdcPuxT9H/uYGFdgqOYeYYYeewNGuTQDMm6z3cVEVSPp9
         4iu0q/8k9NR76mLMKWBzqvn+jYdvSMpaZdiL2TND/Kkg0nWCiSQburDqVzuWP5W1t9wm
         Wv6sIVU+CBt3wGgu5sDK+LIQVpU8l/12+8Vq1ip1YezImSxhUfWDf8NNlpXPZ4ZEXwhM
         h3Vw==
X-Gm-Message-State: AOJu0YxQXlahy4KO32bzsIIHd/wVYmC95S8/72wiVGIphPW2axEdOSXk
        zcXCVvqWQ32B4eds0Rc657Tb9g==
X-Google-Smtp-Source: AGHT+IEa8j0yLIeHYAwnQA6g9TFGV/UMhAAiW6FQVVgLcM2FdadAJBoxqsjXwmn9cohlumUlHsfqEA==
X-Received: by 2002:a5d:6892:0:b0:32d:8b21:40fc with SMTP id h18-20020a5d6892000000b0032d8b2140fcmr11298131wru.9.1698216658927;
        Tue, 24 Oct 2023 23:50:58 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p6-20020a5d6386000000b00327b5ca093dsm11378862wru.117.2023.10.24.23.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 23:50:58 -0700 (PDT)
Date:   Wed, 25 Oct 2023 09:50:54 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     miriam.rachel.korenblit@intel.com
Cc:     linux-wireless@vger.kernel.org
Subject: [bug report] wifi: iwlwifi: support link_id in SESSION_PROTECTION cmd
Message-ID: <5f5db316-3229-4fc2-81d8-3463b5b83d40@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Miri Korenblit,

The patch 135065837310: "wifi: iwlwifi: support link_id in
SESSION_PROTECTION cmd" from Oct 17, 2023 (linux-next), leads to the
following Smatch static checker warning:

	drivers/net/wireless/intel/iwlwifi/mvm/time-event.c:705 iwl_mvm_get_session_prot_id()
	warn: unsigned 'link_id' is never less than zero.

drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
    693 static int iwl_mvm_get_session_prot_id(struct iwl_mvm *mvm,
    694                                        struct ieee80211_vif *vif,
    695                                        u32 link_id)
    696 {
    697         struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
    698         int ver = iwl_fw_lookup_cmd_ver(mvm->fw,
    699                                         WIDE_ID(MAC_CONF_GROUP,
    700                                                 SESSION_PROTECTION_CMD), 1);
    701 
    702         if (ver < 2)
    703                 return mvmvif->id;
    704 
--> 705         if (WARN(link_id < 0 || !mvmvif->link[link_id],

link_id can't be less than zero.  But the bugs are deeper than that.
In iwl_mvm_te_clear_data() we set:

	te_data->link_id = -1;

But here link_id is an u8 so really we're setting it to 255 instead of
-1.  So that means that the mvmvif->link[link_id] is an out of bounds
access.

And generally I know from the type that link_id is 0-255 but if it's
more than 15 then it's an out of bounds access.  I couldn't figure out
exactly where this is set so it's hard to tell if there are other out
of bounds accesses as well.

    706                  "Invalid link ID for session protection: %u\n", link_id))
    707                 return -EINVAL;
    708 
    709         if (WARN(ieee80211_vif_is_mld(vif) &&
    710                  !(vif->active_links & BIT(link_id)),
    711                  "Session Protection on an inactive link: %u\n", link_id))
    712                 return -EINVAL;
    713 
    714         return mvmvif->link[link_id]->fw_link_id;
    715 }

regards,
dan carpenter
