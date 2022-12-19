Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA826515B4
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Dec 2022 23:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbiLSWx1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Dec 2022 17:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiLSWx0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Dec 2022 17:53:26 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D84F12751
        for <linux-wireless@vger.kernel.org>; Mon, 19 Dec 2022 14:53:25 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-12c8312131fso13460368fac.4
        for <linux-wireless@vger.kernel.org>; Mon, 19 Dec 2022 14:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=1wGvNvdq9o/nWQwGtFuGGN5TgUZ6lcAFPvqJqkPs0pU=;
        b=kUQE5cmK4i5se5TOafrPaH+gBhLJSyT2u7eIemb8Zx/SslD5MR6aw0vW8hnwf271AT
         VfxW/a3W6cliFb1xfwKHvr9mLUVitWAh4GCF+qj+rDwJOGKKJcJperTxhr3gXmq4cpAx
         YaBeRuxHddB8BYFMN/17U+Dmho5OQycsonSsXMDBn5kdesjNIHw0tNI4lszVoCakjfLt
         8ifDRLdCL9ygC4OlLp8Sy96UvmEfY+b2qfHiIuVNEWiUQFmkZ2sv4Ym/U1/x9J13unLI
         PND+HE6JUQ4Hkpluj4dPfLKAYzdpoBQTkehK41UypXAb6YzOhk9Fvupibkx1nsLCPROn
         6KEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1wGvNvdq9o/nWQwGtFuGGN5TgUZ6lcAFPvqJqkPs0pU=;
        b=MT2RknQ+6NflW1M/Y3EhqmYajybrl2ni6aHJrT9JMCRuLRioV2jKDCaGXggnMi9Fec
         aoNf0LW2CAV1K8oUMFoFi7MextSOIa3ZHFsmkDH0LLDbugY4dj7NYViUDUeQQHArahOa
         Yh6UBeIaI14EkXcreKVNA48fx+U0t/4x7uCVy08RL7/ns86PttW/LO4eCaws14gJv31d
         phA3FzpdgRMSMcPEYXDjzJoxRv4w3fPFrR1ix+sadVPbKdrUqVO26yKBTTDjpX7dJf9z
         tZIx3iS/iJGUOlxOFaKab8naa5O0o9pjdHQrKcJ5c5uLj1Neuzsnk59G6bt8YAopuIo+
         nGow==
X-Gm-Message-State: ANoB5pmWIetWjes0IyGFWRTjBFYlAAMYNJ5XklUhye8qEHQixTNYND5n
        zBjh9jV966/ukAj9u7hupqvr+aIIB7o=
X-Google-Smtp-Source: AA0mqf574UlpJZV5XlYGcrnZM5+QfSWag4w8zjjGOywYZIUjHywI7JJZq1vDN1p5BQZRVHwZ3LbTMQ==
X-Received: by 2002:a05:6870:788b:b0:143:b833:b5c5 with SMTP id hc11-20020a056870788b00b00143b833b5c5mr19744068oab.50.1671490404444;
        Mon, 19 Dec 2022 14:53:24 -0800 (PST)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id cy19-20020a056870b69300b00143065d3e99sm5346492oab.5.2022.12.19.14.53.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 14:53:23 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <8b86edab-5bd6-cab0-f8f8-f5c6bc757988@lwfinger.net>
Date:   Mon, 19 Dec 2022 16:53:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [bug report] rtw88 / 8821cu driver missing firmware
Content-Language: en-US
To:     Ingo Saitz <ingo@hannover.ccc.de>, linux-wireless@vger.kernel.org
References: <Y6Bnc+UUY3R/nc6L@spatz.zoo>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <Y6Bnc+UUY3R/nc6L@spatz.zoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/19/22 07:30, Ingo Saitz wrote:
> I saw the 8821cu chipset being merged for linus' next kernel release and
> decided to give it a try. I have been running 8821cu from
> https://github.com/morrownr/8821cu-20210118  succeffully, so I know my
> hardware works.
> 
> The driver as merged in commit 07cef03b8d44dee7488de3d1585387e603c78676
> to git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> can't find any firmware for the driver, and the card does not work. At
> boot it repeatedly logged failures to my kernel.log:
> 
> 2022-12-16T19:20:21.563669+01:00 pinguin kernel: [    7.823614] rtw_8821cu 2-11:1.0: Firmware version 24.11.0, H2C version 12
> 2022-12-16T19:20:21.563670+01:00 pinguin kernel: [    7.906497] usbcore: registered new interface driver rtw_8821cu
> 2022-12-16T19:20:21.563670+01:00 pinguin kernel: [    7.930657] rtw_8821cu 2-11:1.0 wlx1cbfcefeb2a3: renamed from wlan0
> 2022-12-16T19:20:59.576907+01:00 pinguin kernel: [  631.847796] rtw_8821cu 2-11:1.0: failed to download firmware
> 2022-12-16T19:20:59.576910+01:00 pinguin kernel: [  631.849195] rtw_8821cu 2-11:1.0: leave idle state failed
> 2022-12-16T19:20:59.580239+01:00 pinguin kernel: [  631.851635] rtw_8821cu 2-11:1.0: failed to leave ips state
> 2022-12-16T19:20:59.580241+01:00 pinguin kernel: [  631.851636] rtw_8821cu 2-11:1.0: failed to leave idle state
> 2022-12-16T19:21:08.563579+01:00 pinguin kernel: [  640.833372] rtw_8821cu 2-11:1.0: error beacon valid
> 2022-12-16T19:21:08.563590+01:00 pinguin kernel: [  640.833480] rtw_8821cu 2-11:1.0: failed to download rsvd page
> 2022-12-16T19:21:08.563591+01:00 pinguin kernel: [  640.833640] rtw_8821cu 2-11:1.0: failed to download firmware
> 2022-12-16T19:21:08.563591+01:00 pinguin kernel: [  640.835040] rtw_8821cu 2-11:1.0: leave idle state failed
> 2022-12-16T19:21:08.566911+01:00 pinguin kernel: [  640.837510] rtw_8821cu 2-11:1.0: failed to leave ips state
> 2022-12-16T19:21:08.566915+01:00 pinguin kernel: [  640.837513] rtw_8821cu 2-11:1.0: failed to leave idle state
> 2022-12-16T19:21:17.550263+01:00 pinguin kernel: [  649.820641] rtw_8821cu 2-11:1.0: error beacon valid
> 2022-12-16T19:21:17.550288+01:00 pinguin kernel: [  649.820759] rtw_8821cu 2-11:1.0: failed to download rsvd page
> 
> There is no mention of what firmware would be needed in the source code
> itself, yet the repositoryhttps://github.com/ulli-kroll/rtl8821cu
> includes a file firmware/rtl8821cufw.bin.

The firmware that is needed is the same as for the PCIe nersion, namely 
/lib/firmware/rtw88/rtw8821c_fw.bin. Your distro should have that firmware in 
package firmware-realtek, or in linux-firmware-realtek. If they do not, you can 
get it by 'git clone 
git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git. The 
firware will be in directory rtw88.

Larry

