Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCDA72BAFF
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jun 2023 10:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjFLImc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Jun 2023 04:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjFLImb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Jun 2023 04:42:31 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60F6FD
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jun 2023 01:42:29 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51830f2523fso2446461a12.2
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jun 2023 01:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686559348; x=1689151348;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XkAtBHZAqEexY8XTljgfOwsv5AHv1wbpBye0cnGEpPM=;
        b=WAs0JyvzR/RmxmAKv7lxMooExqSxJ6YuKowpuEU2Qt6hMQf6H+nnwhPntikudB0dUZ
         7TADMWUlyNANhU/YTU+qUUGWDV44jVW8N2Lc1zTfJBQBq2rLD2OFPUZBHMQW7SrFFjII
         HSRv5en4jt+Bb2ZhPjmIzQqbPArSvkaShCSwtDYUCX+SZ9usJ46ojQByrS4s4sYMp96T
         ++ocKGHoC3WH7KnO75QjxdsRtCxo97Ev6Q5GeiOijXa+V41a5mWmHULCQN1bd60RwyWs
         6/NrUAD3sfTXPsWtwSf8e13eDy7f0AGRtQOWMP33lIGglyYrGnD3CsvgO8qMycoidaPh
         I0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686559348; x=1689151348;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XkAtBHZAqEexY8XTljgfOwsv5AHv1wbpBye0cnGEpPM=;
        b=OdWoJuANpRifz20yTo/1MrgTzgFjZ5lnwdIMK8Z7Gq8y2U68SVdABZlXgUCgdIbSfN
         QLIfPdTlGptCCt9eimslNfu+2bl2YE5vAkGmw88ysH5faR7GAiInb4bCh/m/w0Ro2xgQ
         /5shLCIPGgJf+bknCpGE4Ni+PheuoOSVt/Cuqi11MwgrzsTwOO9nWGVwSLjitr1DQiTU
         cUJd/1O3H/Ew7ZLdyr/MAaoxYNbF5t9H2t0zipqljRgfvqPLI/OBkshOuClUwzLJvksF
         1fkP40HTtlmymGjXpL4oP4a0ryf0f3Sws9NeqBs77DraUumpcpEL7/Oc5hLwyQcnmfbZ
         kE2Q==
X-Gm-Message-State: AC+VfDz6VQ+JTixWlqogq6S/ASb/xZgcWYLwE5Qw30ntRJNzCbvSr4RE
        fZrODOpgFZSUCBuGs8PcyFptCw==
X-Google-Smtp-Source: ACHHUZ67uLX939dGXEu+gmLKwNEWbxc2E5Y5xg5PACugaEyWHvaaHh3LVIz6TsgWNz3YcgwtPwHl4A==
X-Received: by 2002:a05:6402:2058:b0:514:9500:7e51 with SMTP id bc24-20020a056402205800b0051495007e51mr4218423edb.9.1686559348281;
        Mon, 12 Jun 2023 01:42:28 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id g6-20020a170906594600b00968db60e070sm4893676ejr.67.2023.06.12.01.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 01:42:27 -0700 (PDT)
Message-ID: <c8e5772e-0781-0799-0ab8-03694746a3e1@linaro.org>
Date:   Mon, 12 Jun 2023 10:42:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v1] dt-bindings: net: wireless: bcm4329-fmac: add
 ieee80211-freq-limit property
Content-Language: en-US
To:     Christian Lamparter <chunkeey@gmail.com>,
        devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Cc:     rafal@milecki.pl, kvalo@kernel.org, f.fainelli@gmail.com,
        conor+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org
References: <288fc9a0db6c292bc132e828611c41785b075078.1686486461.git.chunkeey@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <288fc9a0db6c292bc132e828611c41785b075078.1686486461.git.chunkeey@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/06/2023 14:37, Christian Lamparter wrote:
> This is an existing optional property that ieee80211.yaml/cfg80211
> provides. It's useful to further restrict supported frequencies
> for a specified device through device-tree.
> 
> The driver supported this since ~2017 by
> commit 0f83ff697356 ("brcmfmac: use wiphy_read_of_freq_limits to respect limits from DT")
> 
> This property is already being used by:
> arch/arm/dts/bcm4709-netgear-r8000.dts
> 
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
> ---

So this is superseded?

Best regards,
Krzysztof

