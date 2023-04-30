Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1816F298E
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Apr 2023 18:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjD3QvS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 Apr 2023 12:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjD3QvR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 Apr 2023 12:51:17 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09571170C
        for <linux-wireless@vger.kernel.org>; Sun, 30 Apr 2023 09:51:17 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-187edc01fa3so661508fac.3
        for <linux-wireless@vger.kernel.org>; Sun, 30 Apr 2023 09:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682873476; x=1685465476;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gupuMT85PsFCdLGK9xdnu1I0pZ/hF2/cc6MmMv6hU8A=;
        b=cTpbTgfhWkOANvqne7bRG2sP1XPZAFG5eC44hxcIVN2hjr/ahl8BZKBMkiS2wXc+sl
         8JbKq4jw8OZgybreMDPjeq6w4WFfP/w7jMotYmM4oUmjvWFDEfJvNtDYV/1GACVQIQt3
         naYn9FKAcV48l2szCeyGICEbgLjNyFPZL1Rln2rXH2RgzSRTYmlMNtvVS/qFU/2o3yV1
         1tQaWamA4N5m6BeITpBRzg83qeDvUY96sK19pYmEWPN2dWIiErCGnEZIfOHbHiUdfFdn
         7l853gwPgBZzxoMJswLaDjN9PPcd9ifFL6HeiuEGZdSc3xGg+EM3E3RtTYSOgMCASKPm
         rtpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682873476; x=1685465476;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gupuMT85PsFCdLGK9xdnu1I0pZ/hF2/cc6MmMv6hU8A=;
        b=KFQFvRcUlItTczOBhRfABuRyvLpXlVODyQw2jPo5cfezrF/tYfRnqLhQdBO3tZCO8q
         QNQMaUVTAvL5UyWiQxl/jA/6OD3iuIeF7OJZltIortub+FifCVGKvmgUem/Nu/oMzGxq
         SJcAxCt9cxF+LRT6e5TOvHvRO6UfZ5Ocn07fmsmRou52LhfjfIXXB2dcwTd9HbyafulV
         wWXOGtqysCUP6UeS1GKVVmC7Bn0x8XDGU3KepDArP2+ofYto8qSDTOlrapX7yC3n1khE
         qOQZP94U5CY8XYWdWgTuK+XJq3TleATk6iLqaCzz68GlCrclU0+5PkHK/CcvFDZQOwNk
         IcDw==
X-Gm-Message-State: AC+VfDwCrTAH5OlYhL5mwxfilY74+vleczwVvJFdfVUjRJfSHAlu406m
        ZbViela3pMG7AjblLiBHpJxyW1KOm8Y=
X-Google-Smtp-Source: ACHHUZ5Pxsq/giM0XwEFqFHoGJOg8AtsJWQ+10CCRPdo47YADdkyuy/uzrDB8PILjbROLSWF7Lyjsw==
X-Received: by 2002:a05:6870:9203:b0:18a:fff0:3f70 with SMTP id e3-20020a056870920300b0018afff03f70mr5424050oaf.55.1682873476314;
        Sun, 30 Apr 2023 09:51:16 -0700 (PDT)
Received: from [192.168.0.162] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id p22-20020a05687052d600b0017243edbe5bsm10702693oak.58.2023.04.30.09.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Apr 2023 09:51:16 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <72a8eeb1-c91c-80a7-5a09-1b7963e0996b@lwfinger.net>
Date:   Sun, 30 Apr 2023 11:51:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Subject: Driver for rtw8723ds
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jernej,

Is there a reason that the driver for RTW8723DS was not included along with the 
other SDIO versions in rtw88?

I have a user of one of my GitHub repos that uses this device.

Thanks,

Larry
