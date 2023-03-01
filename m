Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269616A679D
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Mar 2023 07:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjCAG0H (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Mar 2023 01:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCAG0H (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Mar 2023 01:26:07 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74B3166CB
        for <linux-wireless@vger.kernel.org>; Tue, 28 Feb 2023 22:26:05 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id f13so49590242edz.6
        for <linux-wireless@vger.kernel.org>; Tue, 28 Feb 2023 22:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677651964;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKnahKYvDkOq1G3kybxm9V8jbp0DrWyaFO9RjoxtDLQ=;
        b=OZgrReNxsVqcb+FXsKNKY0upRcB1Hb0j/BwI02Ypa0L95yBSxfaJu73oSUqbG6re0J
         lcI4zdc18OvVgLw6hrPP9vFa/yi0ba1QhQzfsIbg5HJ4a+HP1BCwSJHFqLOVZinJrkuV
         OUcFdlPYg1nQh45s1Y7STtRLNH5UwwkIGDZ20JBtsHE4OKnHQuD08gs7olFuDjt/ecc+
         zVueY4QZCl90TBRlquND7dhA+3e2HAjnO4Zi7y8q1kNRnCdydiQ6Kmy3cw6rNKrX4mmc
         hW8LSCX0qm1d9saXJ9Hco9VXqrVa26lrV6N/enjNp9JnfPSNTbvjJglsuKh1ONGFjpsg
         JjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677651964;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VKnahKYvDkOq1G3kybxm9V8jbp0DrWyaFO9RjoxtDLQ=;
        b=j2gprig1Unk8nbGnM6Kt37Vu9QIfgielbnDLyV+sdCvDSUJ6UWZg3hKQiC2fKERsaX
         IN5RULj3OYqL4sEDIDOBu4Pj6OI3HQl9rUSrh/8jnDN2K+GyfUgacUntFr8RDWSdLPXR
         a0K68LlaqiOCz9ZIO0zicpAba1kgGlOSZiXzV1A1AS7HudSX2RBuVYTRi/kVFXZvlapS
         stusTo4PS4IUtc9KdByOABqwgPuv+wM7UnoZfF2iJ0EtnQqkZWRXlijpL+r1Ni+p28wh
         v4qm2MSctyrhy6tRLWhbkVlPvw1pbfe/iWeow243aMg8y9LKr/LGrPQ4BkGKflODD1EC
         gqTg==
X-Gm-Message-State: AO0yUKX+f2HXWo1UmFpQ+GbebZGe02jGpOL9S2JtnAK/m+4yrS0OesDL
        Zr+9wBzdonQRg63e7EMGNwyNKd/3T8n3TMDs
X-Google-Smtp-Source: AK7set/tX1BeN7BKcFDPP58kS7oHLyMLCeEPCsfBGegGeuZYReYtbCIHsFzjei8XpZcpkY7g4aqHOA==
X-Received: by 2002:a05:6402:40ca:b0:4ad:6f56:a362 with SMTP id z10-20020a05640240ca00b004ad6f56a362mr8100641edb.4.1677651963906;
        Tue, 28 Feb 2023 22:26:03 -0800 (PST)
Received: from ?IPV6:2a02:2788:415:e0f7:b40d:6926:17d9:5800? ([2a02:2788:415:e0f7:b40d:6926:17d9:5800])
        by smtp.gmail.com with ESMTPSA id c21-20020a17090620d500b008e267d7ec18sm5379117ejc.50.2023.02.28.22.26.03
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 22:26:03 -0800 (PST)
Message-ID: <b8fa3770-7164-e6bf-4d8d-8ba8fd78057c@gmail.com>
Date:   Wed, 1 Mar 2023 07:26:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: fr-FR
To:     linux-wireless@vger.kernel.org
From:   =?UTF-8?Q?Fran=c3=a7ois_Valenduc?= <francoisvalenduc@gmail.com>
Subject: Hangs with NetworkManager and rtw8723_de with kernel 6.1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Good morning,

systemrescue recently switched from kernel 5.15 to kernel 6.1 and 
NetworkManager started to hangs at startup. This seems to be linked to 
my wifi card (RTL8723DE). I am also able to reproduce the problem under 
gentoo with the same versions for NetworkManager and linux-firmware than 
those used in systemrescue (1.42.2 and 20230210). Under gentoo, the 
problem appears with kernel 6.1.14 and 6.2.1. I am able to use 
NetworkManager and systemrescue without problem on another computer 
which has another wifi card.

Does anybody have a solution to this problem ?

Thanks in advance for your help,

Best regards,

François Valenduc

