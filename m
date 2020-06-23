Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E402054F0
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2020 16:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732835AbgFWOh6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Jun 2020 10:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732740AbgFWOh5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Jun 2020 10:37:57 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7A6C061573
        for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2020 07:37:56 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f18so3478274wml.3
        for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2020 07:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ceG/rp64xRAj8gur9y870c/+SKauz/Pvvf3Ek5gAYHE=;
        b=S/38hRP9jJeEO0648j5i0HwQUkmAn8MPLasoGaNt8LdCbQqEVydbz8k0QMIB7TcSxT
         mB8W7q1gDfv+vrDORU79pdT175xGSNJNn9FeFSOeCambF0o+fNWV7YZc6bTiG/1Z6IfR
         QyqfeR3sUuTOxKqqFW+5Mj6QQ1oGWLVdX8LKSRdVg1scMMyLuhkobEB7qpI1w1w/qH7z
         jwaDjR41jrisZougD+3Uuakf/CAy6jS5bQHpWHTAieha1OiW3LJqSFRQr/vLShLUiHPk
         yPP9bihWulsfYdzcIcoqxokyu81EfkMggDs54t64ujxNzfIYZShzXVRQcjXTRd7mV3TJ
         lmtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ceG/rp64xRAj8gur9y870c/+SKauz/Pvvf3Ek5gAYHE=;
        b=JbstXtKCZz9FWf9bOG1ZcRL+9Rb99iqluo0pmDjPTBjuXU8K99FkrgQN3q7rGiNNfN
         vJ81JC05Dslc1XtbnDa1fJd3rCbC3V2fw5KtaCqr1V1VZUVA1YpB0NKSV4BCW8H32ooX
         u7MFHlVP4FSb8oG5wuZWYZRjEFvbjfCJEREspQ0G0wPNYoVuKvTF6FYZA+wVbHGnu7uq
         VYcvkeIWHnpc3yzK4efhUzvuYEkq5xD2u0sbsYbNTJFVn1Tz4by/kio0Y0+fz86QJBpU
         zYzJ7p30JoP0hrsdcHU975Y37nfymTocbP4SI16NFMpg37c+9O/2X1cB326OzavFZr/8
         BcVA==
X-Gm-Message-State: AOAM533LgIY+uqRivyghoMvnLsB5eFrV7fsmVVicUk6LB3BsCuF63KdG
        l7u/exRDtK9aj/TFxRqAt90CRw==
X-Google-Smtp-Source: ABdhPJzFhA2lwUjrw8Uh+XlYz4CBl1VsesMxrJl8KjSj+B5PacC6wuAYbyLBKbmaRzqOKAPJJSOTSQ==
X-Received: by 2002:a1c:9943:: with SMTP id b64mr24802648wme.102.1592923075430;
        Tue, 23 Jun 2020 07:37:55 -0700 (PDT)
Received: from [192.168.0.41] (lns-bzn-59-82-252-131-168.adsl.proxad.net. [82.252.131.168])
        by smtp.googlemail.com with ESMTPSA id h14sm6949375wrt.36.2020.06.23.07.37.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 07:37:54 -0700 (PDT)
Subject: Re: [PATCH v4 00/11] Stop monitoring disabled devices
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Vishal Kulkarni <vishal@chelsio.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Peter Kaestle <peter@piie.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Sebastian Reichel <sre@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>,
        Heiko Stuebner <heiko@sntech.de>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        kernel@collabora.com
References: <Message-ID: <4493c0e4-51aa-3907-810c-74949ff27ca4@samsung.com>
 <20200528192051.28034-1-andrzej.p@collabora.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <9cbffad6-69e4-0b33-4640-fde7c4f6a6e7@linaro.org>
Date:   Tue, 23 Jun 2020 16:37:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200528192051.28034-1-andrzej.p@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Hi Andrzej,


On 28/05/2020 21:20, Andrzej Pietrasiewicz wrote:
> There is already a reviewed v3 (not to be confused with RFC v3), which can
> be considered for merging:
> 
> https://lore.kernel.org/linux-pm/20200423165705.13585-2-andrzej.p@collabora.com/
> 
> Let me cite Bartlomiej Zolnierkiewicz:
> 
> "I couldn't find the problems with the patch itself (no new issues
> being introduced, all changes seem to be improvements over the current
> situation).
> 
> Also the patch is not small but it also not that big and it mostly
> removes the code:
> 
> 17 files changed, 105 insertions(+), 244 deletions(-)"


Thanks for this nice cleanup. Given the series was tested, reviewed and
acked, I would like to merge it as soon as possible.

Can you send the V5 with the EXPORT_SYMBOL_GPL fixed ? So the series can
enter the integration loop.

Thanks

 -- Daniel



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
