Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A3D6FB225
	for <lists+linux-wireless@lfdr.de>; Mon,  8 May 2023 16:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbjEHOEL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 May 2023 10:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbjEHOEK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 May 2023 10:04:10 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF7F36CDC
        for <linux-wireless@vger.kernel.org>; Mon,  8 May 2023 07:04:06 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6ab032b33cdso1046177a34.0
        for <linux-wireless@vger.kernel.org>; Mon, 08 May 2023 07:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683554645; x=1686146645;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=iu1LCK9aWFLvkKRKxPgFSQaW4ctFl06OcvYqtORiBDE=;
        b=WRemzRIVK7betkekH7Oe6VQgAOPTMTjxBw+XyJrvOxeqZlE4sGIB1hiYz0WQAHGfhK
         DG9sEXglOybdersXQwubQ3ybhpHEOomblZu7VfaasxxwDxhFDlnICkgaVVws0jlTWlQZ
         TXEySwurNlwwje36Q3UQVv/k7AsMDWR6tQpZGzQq1kyVZfp94R2FK6GmsdrnlSyq7uzv
         KCy0jwvQfu/48VsBOQr1zSP5eNHWql5lTWE34W2T+FCRYf6vLkAt33lKxOPAuQWL2Bq1
         9hNVXVGBCb3hhEjQ+L2Ck1WBxoy8FL3Rfy6iohJrCbLF/Ah0OqYCAx6Ov2ozJKzBhRXp
         uQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683554645; x=1686146645;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iu1LCK9aWFLvkKRKxPgFSQaW4ctFl06OcvYqtORiBDE=;
        b=C2nKIQMZTvcOzb2gSbPjBA8fOlImDDCjPMTPzzVumN7Pj0CV6+l+RPTtsErt7i4XmD
         q47DR8NwWJEZa8eN3J4Mevvn5beDM8jqoQ52pPBDSq13drKNDstwf6Pkdk1L0ZWU+FA8
         UHAKPde/SlXeNLOlnXKmrymk3Np+qsria0Bpsh4b5DYUHm5capsmjWyUjJn7SFK+ngfg
         5p0XipCmID6IwSlzqehmq0hmyYQ9NjTwZdbXC/J+qTl9rZekRwWphMpkExrZqJFRqMJu
         pj04zagX7DOiehbvQ5xnjdI7LY9CcovY7gLCxan1MJcc/QobH6ovOHAIC3fIz0smRlGE
         S/1Q==
X-Gm-Message-State: AC+VfDx7n/qATDSooo8iH5PotU01WmFWaykqk0hmHe8NPNQrPvPZ3gE4
        x3FGQYYWMU6w3daKuOLMmwc=
X-Google-Smtp-Source: ACHHUZ787RmCLw9sv5Df6DrTZRMkU5rKi96KGntL0ufC8ahXOrsaWz49uh6ONqTHR05d/KYGJQ+BFA==
X-Received: by 2002:a9d:6392:0:b0:6a6:f2e:a891 with SMTP id w18-20020a9d6392000000b006a60f2ea891mr5400027otk.6.1683554645528;
        Mon, 08 May 2023 07:04:05 -0700 (PDT)
Received: from [10.62.118.118] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id r5-20020a056830134500b006a973ec4660sm4091712otq.78.2023.05.08.07.04.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 07:04:05 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <3c157ef7-8bf3-e886-769c-c27b9cc00547@lwfinger.net>
Date:   Mon, 8 May 2023 09:04:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [bug report] wifi: rtw88: usb: fix priority queue to endpoint
 mapping
Content-Language: en-US
To:     Ping-Ke Shih <pkshih@realtek.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <c3f70197-829d-48ed-ae15-66a9de80fa90@kili.mountain>
 <ab52f337fdf842499912458efab7704c@realtek.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <ab52f337fdf842499912458efab7704c@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/7/23 21:39, Ping-Ke Shih wrote:
> return type of dma_mapping_to_ep() is 'int' and it also possibly returns -EINVAL, and
> rtwusb->qsel_to_ep[] is used by qsel_to_ep() that also use 'int' as return type.
> Therefore, I would like to change type of qsel_to_ep[] from 'u8' to 'int'. Does it
> work to you?
> 
Sasha and Ping-Ke,

I have been testing using s8 rather than u8 for qsel_to_ep[], if you would like 
to keep the array the same size. All the values fit within the s8 limits.

Larry

