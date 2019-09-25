Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDADDBDC3C
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2019 12:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390006AbfIYKfG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Sep 2019 06:35:06 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33964 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389655AbfIYKfG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Sep 2019 06:35:06 -0400
Received: by mail-ot1-f66.google.com with SMTP id m19so4351454otp.1
        for <linux-wireless@vger.kernel.org>; Wed, 25 Sep 2019 03:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8wzVpUT1lF+LA85bI7Ppewnhb+cRPfMX9zvQYDu2GVU=;
        b=Wi5Ag0SHfzxXZInHydI4YbqTIB/rrxCCL1JJscBC7KJCrxqB4Ihcn+UIjSPYjwKNch
         7cBa5Lxf5Asnek9AGEu7V36waFAgT7Or0k7KzIQ7IqGDEtdO/MXNsdY5WBtitHzWOQug
         dUsljL/wTOy+dxiX1U3vAHWmR9SN7rWKDO4xvpVJxDfg4q8fkQBIJKe6XT43I+awGL9n
         0PtaYQaGTZf6vRsZpwOZj2V0vHGkpFSCuBIcN+YY78+rZf/1/LvnDEwI2PZuyWI6wHmh
         kjxQiEMtUzmTUqeGS+dL5jv7ZhYB7rocdWN8xmwn+eQsu0engwyPl9ftTLcelVUVEqxy
         8+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8wzVpUT1lF+LA85bI7Ppewnhb+cRPfMX9zvQYDu2GVU=;
        b=qTK+/gIbQXm7gmdsC4rV4gCDquC/5Ce0P/VS91d/n5fwqcBU6A6KNHp9XSjXYdflYX
         DkhC7U45f4kQtr/6MQBpNu/+4PWI788v1aUxHhQg7KglN1jpm6PizN+7Oi4xJmApJbBc
         tkiTj49nv4zBSz6ZBoc1XFudgUZUy2os41VZIYVYUIFTvWFgHP1rva4lfmItgdw/nXxB
         njqm3j1o6Vp/GpCersT1n2Qr9NJHSuIRqdldkvEVpmHKzbHM8achpZYQ/AyZ5j3amvEZ
         ppB+50Z8oSZx3PLK9b47GRAD0Ag/qIah8Nblv2ZlQTmCMw3Xr0fDA1Oeux8lpIvORPcq
         b7Yg==
X-Gm-Message-State: APjAAAVIAZ6gQzkdc3nws6nyrqK4eJ0rT7xtD0CPJ1MdhFaE9Ii0k9Yz
        O4lbfU6qoJfkFgqS1yKB/2l/Hx0X6wN6dE/grTQ=
X-Google-Smtp-Source: APXvYqyX/ZlcKUdbiApg5M1nDcipCDSrDxDkBnkm+TsyGlNqd0QuRU4h563tY5h2saYISCa6BDUaXRSCxfZliuxl4KU=
X-Received: by 2002:a05:6830:5a:: with SMTP id d26mr5405952otp.256.1569407705902;
 Wed, 25 Sep 2019 03:35:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2286:0:0:0:0:0 with HTTP; Wed, 25 Sep 2019 03:35:05
 -0700 (PDT)
In-Reply-To: <a87917de-d60c-b746-742a-ade37ffe9c4c@candelatech.com>
References: <1553025580-6118-1-git-send-email-pozega.tomislav@gmail.com>
 <2715bcef-5b03-fc19-e665-3c6f90a7d123@candelatech.com> <CAKR_QVKfb5vkT1xmmEyvJzeb+VnPx8T3ZpkdLPTMx+agtSBYMg@mail.gmail.com>
 <a87917de-d60c-b746-742a-ade37ffe9c4c@candelatech.com>
From:   Tom Psyborg <pozega.tomislav@gmail.com>
Date:   Wed, 25 Sep 2019 12:35:05 +0200
Message-ID: <CAKR_QV+TDi5DQ5Vsc-nactAryzAExe470VNJ+tj+vUa37rs_Xg@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Fix ASPM L1 state on QCA988X
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Ben Greear <greearb@candelatech.com>,
        Sujith Manoharan <c_manoha@qca.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi

Some more info: the actual regression was introduced with the commit:
ath10k: enable ASPM - reverting this change only is enough to have
card operating as expected.

Still, this patch would apply, but in slightly different manner.

On OpenWrt router, masked value would always read 0x27 with two cards
tested QCA9862 and QCA9880 v1.

But on HP laptop, QCA9862 masked value reading was 0x0f, and writing
0x27 to this register still seems fine, as long as the faulty ASPM
change is kept reverted.

I did also notice about 10=C2=B0C temperature drop in ath10k_hwmon and no
more crashes when resuming from sleep, but that might be related to
the fact these tests were now done with backports-5.1 instead of the
in-tree 4.9 driver.
