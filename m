Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4207F6C2AFD
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Mar 2023 08:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjCUHDa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Mar 2023 03:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjCUHD2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Mar 2023 03:03:28 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9EF975C
        for <linux-wireless@vger.kernel.org>; Tue, 21 Mar 2023 00:03:25 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id d17so4128283wrb.11
        for <linux-wireless@vger.kernel.org>; Tue, 21 Mar 2023 00:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679382204;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mIKihiROMplwiYmZDCvTzvlFpsqPm+SfOm9J06FIASQ=;
        b=dwVcLRW8fBUP9+IWEfwV5jsm05M5xybC0ARer2YdwTwIwgeFFqJ5AR6CUqQd8ZcQNJ
         m7wBGOL4fb3T/BZ8UShnLwvpc5sVMcKvhHxtPa+xHPquNevSMQJNq1u0xnsGKZs55UTD
         q34MxMIArfQXcwxZ12jzGahGZJdWr/wzbyOrfalNfIuUMywiQ0FdZy8XmbNAyGjL0QWU
         WQxUh55nInsWoTSuqfvV/lQU1x3vMbnYXFE0M4y29xfEjcENHvaMnwH/bJ/rsji+DDaJ
         2/cYJcwENHs2nM7415u9H/Quk0WyziXehYOan8WKIwyZqmtYMmjBqlUYZd4gzYruWAoS
         dEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679382204;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mIKihiROMplwiYmZDCvTzvlFpsqPm+SfOm9J06FIASQ=;
        b=EFQajQoZez8pyEFeRK2Tnu6UOZv9KGbDdqw9YeQetYLX2UjJIxJ3qW4Gm7WbOBI/2C
         TU8urVbBN+ddcJRSOgXXjhwD9LcJIs37pWzgloIPDvBbI4v5KYUlcjK0Ly59/ZmxV8B4
         fFrBQeJpygulcAr40oTwkA1Yr1JJjYoiZrLOt5VvuBTy15viQw3jr3KQCOcBF7v/8Hll
         CsbM24pAC/x8Ofo2qR94x4WKFh40U3qqGGyb8O2S60ak1VmgBH9HP25uvjJ5/Z4ARafs
         cSXqbWmTXhIyc8AqM39ROqmvNl4yiaiERqk/55T4d5yTpezQhiXpf/nZCOxPeVH2Evzi
         Ypow==
X-Gm-Message-State: AO0yUKVLh/7D1T9fW33ZqSZEhApdH3MyOff85blFH49oKRoarMXmveEN
        qHY4qx4VTK3kNBaPZuIcOOk=
X-Google-Smtp-Source: AK7set+/FMyKCd7VndW/13BISwxGiwtpBtWrVvDMeon9FZA4Sq8ShVLiB35NuG6A3cT6D7uM5RJyIA==
X-Received: by 2002:adf:edc7:0:b0:2d6:6d24:7636 with SMTP id v7-20020adfedc7000000b002d66d247636mr1311322wro.7.1679382204397;
        Tue, 21 Mar 2023 00:03:24 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id h13-20020a5d430d000000b002d75ef32032sm3608081wrq.68.2023.03.21.00.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 00:03:24 -0700 (PDT)
Date:   Tue, 21 Mar 2023 10:03:20 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     miriam.rachel.korenblit@intel.com
Cc:     linux-wireless@vger.kernel.org
Subject: [bug report] wifi: iwlwifi: mvm: add support for the new STA related
 commands
Message-ID: <ca7d3085-b6ef-489b-8601-5743e5d4bfeb@kili.mountain>
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

Hello Miri Korenblit,

The patch 006c152ac9e5: "wifi: iwlwifi: mvm: add support for the new
STA related commands" from Mar 14, 2023, leads to the following
Smatch static checker warning:

	drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c:239 iwl_mvm_mld_rm_int_sta()
	error: NULL dereference inside function

drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
    225 static int iwl_mvm_mld_rm_int_sta(struct iwl_mvm *mvm,
    226                                   struct iwl_mvm_int_sta *int_sta,
    227                                   bool flush, u8 tid, u16 *queuptr)
    228 {
    229         int ret;
    230 
    231         lockdep_assert_held(&mvm->mutex);
    232 
    233         if (WARN_ON_ONCE(int_sta->sta_id == IWL_MVM_INVALID_STA))
    234                 return -EINVAL;
    235 
    236         if (flush)
    237                 iwl_mvm_flush_sta(mvm, int_sta, true);
    238 
--> 239         iwl_mvm_mld_disable_txq(mvm, NULL, queuptr, tid);
                                             ^^^^
You can't pass a NULL sta pointer.  It will crash.

    240 
    241         ret = iwl_mvm_mld_rm_sta_from_fw(mvm, int_sta->sta_id);
    242         if (ret)
    243                 IWL_WARN(mvm, "Failed sending remove station\n");
    244 
    245         iwl_mvm_dealloc_int_sta(mvm, int_sta);
    246 
    247         return ret;
    248 }

regards,
dan carpenter
