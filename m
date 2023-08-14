Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8680377BD70
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Aug 2023 17:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjHNPvB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Aug 2023 11:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjHNPu5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Aug 2023 11:50:57 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D43A3
        for <linux-wireless@vger.kernel.org>; Mon, 14 Aug 2023 08:50:54 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1c5046642b4so554920fac.1
        for <linux-wireless@vger.kernel.org>; Mon, 14 Aug 2023 08:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692028254; x=1692633054;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=MAbP+oppZM0K+b8892B7RBKuzREOS8DqaaeZ7dhptRY=;
        b=JMxeoC6mOBls6vLyDA/eCeT7gX9kyTeK1E0HxE5azj1qihuQQlllI4GrhLLpqRJNfF
         Phbua7WkN5djxBSV8X4XR8HmSCBht748dyGS4Cq7EZBSbpjfwX1DMkgwKjrvam7xdAO1
         kvXweZuw0DETNlnNtAnd3ceo+oQrzXaCwfYWqrLNKm5FPGLjQ8p55AoB7mP4JU0Y4OcB
         hkB9zDkYHcO8LLycAM4x83wxmjf3CptK+WEGLZw3GoX7ZQp+OgogILMGa76dS25e4vYd
         qB/bYyaqirG2CNT6hLBzh3IOPaPhVUaAq1UgS10pNtelcs9XmTNZz12MiIq4j6QxW2+9
         1iCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692028254; x=1692633054;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MAbP+oppZM0K+b8892B7RBKuzREOS8DqaaeZ7dhptRY=;
        b=L+flGhK0/glIQPeBnND/6p6IcXsRr8TIfLW/foo6mSgJGojLS8766ZJMm22sqcZD74
         WHXRUgs5wZIcIi+eAreORDfDD3Fku9or6l/qVtM3XEjtLCADM1KoJXjzMtSbOpzgIjM1
         o4KKq9dediFGGISr5etg77rd5TxRxQwyy4IeHo50buUSp8af2AV1UTUH3PFfVMkq6Fck
         kReJsqlUaxUceFNM9Azcx4iuGNKDh5BxZNmIsOdCYrwM3XPUhQ7BenqslglfOn/PIWvb
         xccrLMT/7Hcyw7MPNygmJ6RgAvwGGP7Xw2rDtgAJwoxk5CQOnD/8pKE4UzcPbDzgivNq
         BcQA==
X-Gm-Message-State: AOJu0YzxE+3SYmP0lda6jI8a+YL9KELgMZUge1ygsjRe+EB44gakUoX4
        pDGbyK0YJy5u98ZnLIgwyo9Q0dRbrRc=
X-Google-Smtp-Source: AGHT+IF/VbxnUVSlONrquoUaiyDKwUR0qIgjzp4vYtODqHPVW19hKzVdU7UE8+G8T7+LD+SspJ5T1A==
X-Received: by 2002:a05:6870:8a0d:b0:1bb:5353:336c with SMTP id p13-20020a0568708a0d00b001bb5353336cmr10691939oaq.48.1692028253747;
        Mon, 14 Aug 2023 08:50:53 -0700 (PDT)
Received: from [192.168.0.162] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id j4-20020a056870a48400b001c4d922b4fasm2250630oal.8.2023.08.14.08.50.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 08:50:53 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <4e29cf47-c493-37d2-cb30-416315339989@lwfinger.net>
Date:   Mon, 14 Aug 2023 10:50:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: rtw89_8852ae : failed to recognize firmware elements
Content-Language: en-US
To:     Emmanuel Mazurier <emmanuel.mazurier@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <CAOc87ak7jOQDR5njcM-qTn6XFq_w6p64uVaiXpNtBhLp-_NGeg@mail.gmail.com>
 <ba862f2103d7321484af73f55f31643570625c08.camel@realtek.com>
 <CAOc87an-E=zmZcMhkaKTV7hmr4PagFq0weR=n3hzjJ9wENaPwg@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <CAOc87an-E=zmZcMhkaKTV7hmr4PagFq0weR=n3hzjJ9wENaPwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/14/23 09:27, Emmanuel Mazurier wrote:
> [lun. août 14 15:39:19 2023] rtw89_8852ae 0000:09:00.0: firmware:
> failed to load rtw89/rtw8852a_fw.bin (-2)
> [lun. août 14 15:39:19 2023] firmware_class: See
> https://wiki.debian.org/Firmware  for information about missing
> firmware
> [lun. août 14 15:39:19 2023] rtw89_8852ae 0000:09:00.0: Direct
> firmware load for rtw89/rtw8852a_fw.bin failed with error -2
> [lun. août 14 15:39:19 2023] rtw89_8852ae 0000:09:00.0: failed to
> early request firmware: -2
> [lun. août 14 15:39:19 2023] rtw89_8852ae 0000:09:00.0: firmware:
> failed to load rtw89/rtw8852a_fw.bin (-2)
> [lun. août 14 15:39:19 2023] rtw89_8852ae 0000:09:00.0: Direct
> firmware load for rtw89/rtw8852a_fw.bin failed with error -2
> [lun. août 14 15:39:19 2023] rtw89_8852ae 0000:09:00.0: failed to wait
> firmware completion

This set of messages is what happens when no firmware is installed, thus it is 
not surprising that the device started working when you actually installed the 
firmware.

A kernel update should never delete the firmware, thus the procedure described 
in the GitHub repo's README.md is correct. A new kernel requires a rebuild of 
any out-of-kernel drivers, either manually or with dkms!

Larry

