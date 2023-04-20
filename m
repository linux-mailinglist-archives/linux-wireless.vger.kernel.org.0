Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE136E985A
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Apr 2023 17:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbjDTPdn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Apr 2023 11:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbjDTPdm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Apr 2023 11:33:42 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFBB3C30
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 08:33:41 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l31-20020a05600c1d1f00b003f1718d89b2so3306042wms.0
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 08:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682004820; x=1684596820;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ouBeSfy7/d0qPAy9m1/F6lDJO78/J39/zwWBGqe9nk8=;
        b=TElvrIhjoMGiHz7AuhQ2AdMzKURgi8dQ5eG1MTbqAAuuorO980uCRh7WaDwROcX+CZ
         jXn0aNymOA/0i+2ZtaKq8s9y2AYX+Xi0Q8qJ4yQCKbs52AzTnU5VdtGEjC2bJB6Nyjrf
         BUOadwTsXv6aDjHcpQ6DMs8R4dG/3XvGD/BYair3PJUTEpl8ui/dHn/Eh3YnXFkgAsbG
         wtRhDL3yhqi26VTM6fgROmCS94PB1YzOsCJa4eQoyGPAJdyb9hfS5nfm8DgLEQnS/hmR
         XHrnkjr08hdZgekultUOAnbZ7cHMMWpthBPJqgIUDC5xYHdwKUgE3oSLHDg/+eh+SzsY
         2rWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682004820; x=1684596820;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ouBeSfy7/d0qPAy9m1/F6lDJO78/J39/zwWBGqe9nk8=;
        b=jo5X1ZGJLdk+/bVpm5I4D01J1yNIN8wYyyP+f3CnlvFI4IiA0sVMseJvDyk77oCgU7
         zYlvxCZTffzw1Svc3buJrqZ+hzm4FG6Uf0Bd2s2ezKVerXqmpjCqAA9QGmCVylN3fO70
         YsztIPaj9+DjI7vIAPysXSh9afgs2zlaWHcngJRmAypkuvkUifejNcLjvU6Bk8Ot1lB0
         oRLH98TLfFkh20+scb8LfguOuRd4ShxlUTFETOHmS17+bQPUPgi7Ou26nxM9ur7FkkXJ
         ij6OB+JUKqZo0Rco4eFAAwCZiFF4EOb7nJEO8NMTfF/o1hYQDYyr2MmS5O/xdue5jmWE
         yL5A==
X-Gm-Message-State: AAQBX9c3zTq2DLbiwRwt125GovcqXFbcZJuHwEAGcrfysZMA/vrUBuRs
        gFpQtPBswWIJA9I7TzhKwd0=
X-Google-Smtp-Source: AKy350ZIPWuwKW3uFJaJG+wym3qv91qKdrXhsK6LTQKeRJILc2tOaGItkw9juu020LmhtGVSVeFFJw==
X-Received: by 2002:a7b:cc85:0:b0:3f1:738f:d3d1 with SMTP id p5-20020a7bcc85000000b003f1738fd3d1mr1739898wma.4.1682004820062;
        Thu, 20 Apr 2023 08:33:40 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.55])
        by smtp.gmail.com with ESMTPSA id t10-20020a05600c198a00b003f16932fe7dsm5812204wmq.38.2023.04.20.08.33.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 08:33:39 -0700 (PDT)
Message-ID: <3ceecfc1-ab04-7d54-51bd-457a4708c0ac@gmail.com>
Date:   Thu, 20 Apr 2023 18:33:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: RTL8188EU (LogiLink WL0151A) - Malformed packets
To:     Artem Makhutov <artem.makhutov@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <CALbLcfAXrHp4vsVGqU0nBdB_gFmKTKx0GcdrFJA7R_kodAy0Ew@mail.gmail.com>
 <bfe732f4-60dd-4d78-1259-5f9f6c11adbc@gmail.com>
 <CALbLcfB7cMctHC-Fv93z1WVCZkQ76uW2F_=P6rCW7ZSPXvmapw@mail.gmail.com>
 <2857f998-1b1a-e3c2-20fe-d03dadcf8f23@gmail.com>
 <CALbLcfCsyGzhvrqjSz37+7cLvc3rc4Y_kgspZV=kiPNs4TBE4w@mail.gmail.com>
 <CALbLcfBnF6njFMSfQk2TuOiZ3C3kHwqs4-c-MQGb72azzQ5sJA@mail.gmail.com>
 <38172c8e-d107-d96e-7292-09d0e3b061dd@gmail.com>
 <CALbLcfCHLU+zoFdTnTrJs22UUYwr2rETp5hqbv=NL352Qz-XgA@mail.gmail.com>
 <CALbLcfDZJmOyn-Gf24+9X-eHh3-3PY4_nP5soG3gHf_Vn85=EA@mail.gmail.com>
 <CALbLcfAiVgGi9iocEG4OfgET2XLDRq0dthbxDMP0vP3R6BBp_A@mail.gmail.com>
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <CALbLcfAiVgGi9iocEG4OfgET2XLDRq0dthbxDMP0vP3R6BBp_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 20/04/2023 14:40, Artem Makhutov wrote:
> Hi,
> 
> I think that I have found the problem: It happens when rx_desc->rxht
> == 1 - then the urb is 4 bytes shorter...
> 

That's very interesting. So it has a problem with MCS rates

According to Johannes Berg, the 8 bytes at the end of the working ping
are the MIC, which mac80211 will strip. Of course mac80211 doesn't know
that rtl8xxxu sometimes receives 4 bytes fewer.

What kind of encryption does the network have? Is it possible to try
without any encryption?

Another thing to try is software crypto, using this tested patch and
the module parameter debug=0x8000:

diff --git a/rtl8xxxu_core.c b/rtl8xxxu_core.c
index cbf39ff..779f781 100644
--- a/rtl8xxxu_core.c
+++ b/rtl8xxxu_core.c
@@ -6651,6 +6651,9 @@ static int rtl8xxxu_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	dev_dbg(dev, "%s: cmd %02x, cipher %08x, index %i\n",
 		__func__, cmd, key->cipher, key->keyidx);
 
+	if (rtl8xxxu_debug & 0x8000)
+		return -EOPNOTSUPP; // use software crypto
+
 	if (vif->type != NL80211_IFTYPE_STATION)
 		return -EOPNOTSUPP;
 

