Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD2776F583
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Aug 2023 00:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjHCWOD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Aug 2023 18:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbjHCWOC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Aug 2023 18:14:02 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED064212D
        for <linux-wireless@vger.kernel.org>; Thu,  3 Aug 2023 15:14:00 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3a751d2e6ecso1136170b6e.0
        for <linux-wireless@vger.kernel.org>; Thu, 03 Aug 2023 15:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691100840; x=1691705640;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YH/5Wjaj6/s3Rb9ZGE1cBpRob+YY+Rz1P7/O042r8C8=;
        b=jDdLTiNq93vhqr6Zt6XrVI+rm2KJA1LTZx1aG4qLooews1MO0zI9saJBFmd8KYEAyx
         JVuW06NZdPT8I6Xsyw/Lc0wptFh1kEs9l3EPlgyGFGPvzePkTpJXj401dsGMinrmbnDS
         DWbrgXBHjfBa9yb+xkaOK81oQXXfOt+PVp0VMlYeiWMY2Hi2FxJL8sDBePg4IkPzDIAn
         Ew16PdclB+4k7WNbdEPHjj4dMpAeSphuQ2pU4sCrYvM8kPhLbPWnxn9T98yKf6KvXq2w
         +2o5bliKWiSwrlNTTuU7bXB4blPxfQuAxaewiwQr4GZ0EiNKoACeZsohKPTLnl896AjI
         AeHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691100840; x=1691705640;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YH/5Wjaj6/s3Rb9ZGE1cBpRob+YY+Rz1P7/O042r8C8=;
        b=F1eGAc71feFc67zh1qcz1Y+szN1mc5Y7llAsUeIGA3irSZuvWMXa84u35/GhMSZLk1
         wE70NNEa9gOvU9UxBtnhHjlUp7jOSqJ/97BotpQ4guYzEjklxZdNIFHUvef+qHknuMaq
         vGUfUvAnXOPYNULNGoHosCxWNJOZyxXgGTl9nDBIr2fRtHcGSfWC0lfjalFNy3FYERI4
         QJaQzOeRaojW2kw8PpsvjefjsHG/OC4/MOtT/TtpZbuAYKkm99+t2QzUWX/A5trE+sZX
         Ph6v5dBibJfhDoVA2bJP1NZFFXdcHhqciWHT4TEE4h+gQP+n3M8oQ+pGf9gITdMOkT+L
         0AXg==
X-Gm-Message-State: ABy/qLbq4c9H8aokrVRM+a4EGnyqC4mPmaIrlsnvgu7srpyAtHkyY8Qe
        kEqJy3cQzY0UbckAKA91BqENCNnOySw=
X-Google-Smtp-Source: APBJJlG1bHpxdCw4OxoUsw67KFr03+KNd+qZj7SZdSI/MABjTC2XkNlEALyXL7rkRg+4Vq/POaS6NA==
X-Received: by 2002:a05:6808:bd1:b0:3a7:3b6c:ecb9 with SMTP id o17-20020a0568080bd100b003a73b6cecb9mr16966927oik.22.1691100840113;
        Thu, 03 Aug 2023 15:14:00 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id o8-20020a0568080f8800b003a1d29f0549sm349120oiw.15.2023.08.03.15.13.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 15:13:59 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <813e9c3d-7fbd-7589-ebd0-6c61f03f970b@lwfinger.net>
Date:   Thu, 3 Aug 2023 17:13:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Content-Language: en-US
To:     Pkshih <pkshih@realtek.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Subject: Regression in rtw89
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke,

A user of my GitHub repo has reported a regression beginning with commit 
26a125f550a3 ("wifi: rtw89: correct PS calculation for SUPPORTS_DYNAMIC_PS").
The user finds interference between wifi and the BT device that is part of the 
package.

We were able to determine that loading rtw89_core with the "disable_ps_mode=y" 
option does fix the problem. Our discussion of the problem can be seen at 
https://github.com/lwfinger/rtw89/issues/262#issuecomment-1664658764.

Reading the patch in question, it seems that a vif count of 1 is not sufficient 
to enable PS, and that it is also necessary to make sure that BT is not active 
as well.

Thanks,

Larry
