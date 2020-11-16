Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580482B3AAB
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Nov 2020 01:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgKPAAW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 15 Nov 2020 19:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbgKPAAV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 15 Nov 2020 19:00:21 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF63C0613CF
        for <linux-wireless@vger.kernel.org>; Sun, 15 Nov 2020 16:00:21 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id l1so16848987wrb.9
        for <linux-wireless@vger.kernel.org>; Sun, 15 Nov 2020 16:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:mime-version:content-language
         :content-transfer-encoding;
        bh=sBqxC1n3HYYvQsBab61jQw2vYCxmzr11YsfxnaoVS6s=;
        b=OTaV0JAvVBOKu7JXLlQgc0+XpRdpnSjhAEmC58xszaGPfkl8rTQNC4OL17Iu+PxKYP
         6ko2zg54iduWbsWqi6G9eokqzm9FBvBuX3drXNvtkaXjoqXgcsAnnWgHoQVIEqYyUamx
         +JpMi/R53GkQaR5z4+bPbLs6XyEUnvNTr/EA3B2k6cMqBjleymIq5bEwu9z0sVmHD+kX
         8W0/3RjTBlLlk9B0uh3ZyoNX5hivBDHTAQwWi21rxMF+QLHG7QOPXzs+vYocEOU4almi
         FE+AmVKVrUARrwiROM5Cb0GFt7GkgSle/2f/VmEpgQ4dawbBB8yP1VYW56Hdi3xVrzOj
         Il5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:mime-version
         :content-language:content-transfer-encoding;
        bh=sBqxC1n3HYYvQsBab61jQw2vYCxmzr11YsfxnaoVS6s=;
        b=qskRS0mRaFtnXHbNR7rbWxd7HEXPOdFHK5l8FTpBcR8u0X5WATGurHNC8Lf7exVO3D
         VLEMkXY7EBMcOzTpVGb9prmIGnpqGDamu4S4rAUGgFW9r0CeuqvMWzfsO994Ba5b/wyH
         bifozK6B9p8dBKMiGAiorPHdIJoNm7GTEZNgbC90RisQnH8F6N6IifO7akbIHMfJ9kV/
         uDtYXrdojY9cSjwfuB2yqIubJRfb2frVQ9Xl+YtXRwe1kFrxkAXy226h6t7Fr58yQHlv
         HYpxkjc6k6nALrkdQFmlh6ameuzNuTAMj8mnUlF9cFnYEwF88zXqvqnlQgZCwLH0n4ps
         IZxQ==
X-Gm-Message-State: AOAM530jmF2tIh3JnAiiNeruldbsj+x1XLo90mmj4NfxSKNb8dWYm9iO
        ml2qI8x1+vWQKdysUpfEnfGpEzGDrv9N
X-Google-Smtp-Source: ABdhPJy9eLhjcdPeFGuA8J429ARMDlnk+c+wSh70qMgP/C1lUt5I5x1WK9cmkZVHH0Q54zGBf5cGow==
X-Received: by 2002:adf:d0c8:: with SMTP id z8mr16659950wrh.288.1605484820008;
        Sun, 15 Nov 2020 16:00:20 -0800 (PST)
Received: from localhost (200.red-95-127-152.staticip.rima-tde.net. [95.127.152.200])
        by smtp.gmail.com with ESMTPSA id e3sm3601770wro.90.2020.11.15.16.00.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2020 16:00:19 -0800 (PST)
To:     Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
From:   Xose Vazquez Perez <xose.vazquez@gmail.com>
Subject: mt76: missing 4 fw files in linux-firmware.git repo
Message-ID: <bb8c3ffc-2835-e63f-f39b-8758f919d40f@gmail.com>
Date:   Mon, 16 Nov 2020 01:00:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

mediatek/mt76/mt7603/mt7603.h:
#define MT7603_FIRMWARE_E1      "mt7603_e1.bin"
#define MT7603_FIRMWARE_E2      "mt7603_e2.bin"
#define MT7628_FIRMWARE_E1      "mt7628_e1.bin"
#define MT7628_FIRMWARE_E2      "mt7628_e2.bin"

Thanks.
