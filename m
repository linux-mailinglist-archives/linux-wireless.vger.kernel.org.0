Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E971356387
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Apr 2021 07:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345013AbhDGF4I (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Apr 2021 01:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243610AbhDGF4H (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Apr 2021 01:56:07 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA80CC06174A
        for <linux-wireless@vger.kernel.org>; Tue,  6 Apr 2021 22:55:58 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u11so4097552wrp.4
        for <linux-wireless@vger.kernel.org>; Tue, 06 Apr 2021 22:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=f/i6GZQOsqzqqFrpduRgAJGz1/Tlzoxj0Fs+sTejo+w=;
        b=Z1FDTnl/e87Iithkovr2GweLCZPStXhQnldZRAZWBty6c9L5FFY6sm6rRZkQyBBIQX
         sglzpybtumKbpnekYDpcUNm3KCrTD/D4APT954eti0fSlzsOmWoFtDCyNQyLBM4LNS9l
         Sn9lBDQ03jY7PZC8eM4YZgw1Flp/fxqa5DAYLUoi+86FbB2MO/j6q4feWtq4sBCzmE10
         n6gVmptsboJQhgpDziv0itTugo0EIlwsEeEm4ZYaFAKA1T4mSb7b1YDMbJkESNdCbjLz
         lZf6xky5JrXMQ5MLPE6K+TRY5Dvo+gIGaVCv3dUlGpqCJfBX2EyffanRmpMxduzrkLKQ
         iUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=f/i6GZQOsqzqqFrpduRgAJGz1/Tlzoxj0Fs+sTejo+w=;
        b=t8kNXvWQvxGII133H6zVuZWcXV6nWTzASM/nC2yIP6Tc1WJhwZU5lMsJndyRaN5ckv
         CkXldvPgbssVj3zekQT7jkH7U5oMxdwAnJ4V+HoKLpLxhIsdcOdQEC+79G2o3MxazNk8
         2tyU6NvU3Aq+hDEXdJDjxkvs+8jfZBi3iLYqvkbHDy0BmNm4kb3jR3hwVS1E/+9Healw
         mE2HnD8thd7t5h4VDmPjI5AjqaTO8c6nhbMm2sJCtzZ/dW4Dm1m1fY/daQgWzIriYpT/
         LLT2qYLo5JbJ9U5ReNu9BMQZDFF6ZCjpDb+Zmt01f5Dcw34aerPJ0dAmASkgqyhbP3DB
         ROFQ==
X-Gm-Message-State: AOAM532svKks+z9bj5ke9UxWiKH+YegMZ7vPvSxgOXKIgHjYvCSCWZgf
        AniKkmzriW06Bws6gZNhqsqPvBBDx5Y=
X-Google-Smtp-Source: ABdhPJxDYRaDqn/Il2tCwD2mIsWGb9S/yM5QxOorLGU9vjhLMp2o7ojq07FTEQYYZ65dVW3G8gtHCA==
X-Received: by 2002:adf:f3cd:: with SMTP id g13mr2199772wrp.286.1617774957208;
        Tue, 06 Apr 2021 22:55:57 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:15f8:68c8:25bd:c1f8? (p200300ea8f38460015f868c825bdc1f8.dip0.t-ipconnect.de. [2003:ea:8f38:4600:15f8:68c8:25bd:c1f8])
        by smtp.googlemail.com with ESMTPSA id c8sm40563974wrd.55.2021.04.06.22.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 22:55:56 -0700 (PDT)
To:     Jiri Kosina <jkosina@suse.cz>, Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: iwl_pcie_gen2_enqueue_hcmd needs same fix as iwl_pcie_enqueue_hcmd
Message-ID: <b71f7f03-fa87-74ab-4f10-5cebe3e70b60@gmail.com>
Date:   Wed, 7 Apr 2021 07:55:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Same fix as in 2800aadc18a6 ("iwlwifi: Fix softirq/hardirq disabling in
iwl_pcie_enqueue_hcmd()") is needed for iwl_pcie_gen2_enqueue_hcmd.
I get the same lockdep warning on AX210.
