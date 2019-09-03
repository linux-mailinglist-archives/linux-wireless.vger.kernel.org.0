Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A765A72CC
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2019 20:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbfICSv1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Sep 2019 14:51:27 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35178 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfICSv1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Sep 2019 14:51:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id n10so678573wmj.0
        for <linux-wireless@vger.kernel.org>; Tue, 03 Sep 2019 11:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eo9jXOlCGyENlifp+8Tixo/xIlI5SRIRfMlJ+m3uPdY=;
        b=MXFIsrfPgD5fS3rSG0qkeNQ5RHcHqRDEnEk42Pse3b6geUOGrFA6QTKz277OqnPNcX
         vgumzjn7kd9xk9DBB6/OH7HXY688Do1d6PdKdlRmrll/BXbk94WvLa28UoERb3OXdUQQ
         RpcbTKTy07qH1rwTawAfle4aX2DKli9nz3xwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eo9jXOlCGyENlifp+8Tixo/xIlI5SRIRfMlJ+m3uPdY=;
        b=UKlFAIJbYcrbctH3zNW+LdHUaAmH7eWF9UOO51gDtmBb0w2L0wrDjNj/TlnZxavS+q
         IwzYEbypXX9g3SEK7sQ2Hc/87jrAVjs/Rw/cuWirNMl9U8rsTzNcqs1kWtl1WAL1kv4J
         BAPBISAOtTI6Pf7m7iaPnxbyBQfWdAs9wUjMrQjX+3KAiil1+inclBQ8nLIIiUUY7dl+
         cjXOGJkCTa8bZb6q8twGLawkEQAj/7f9/jupcJ7BJ+tw1Bnj3XhyFCuirsIiG4S7ZEW5
         H3D7z0sanC/+5EW7TgkILW1nyIffAUhIS78EDQNrfWA5V33vXZ5uuZJ/7bp5eI9jgepR
         Sr1w==
X-Gm-Message-State: APjAAAUGfPWkSYjlcHsEfmUUhpu8ieR0HNgWkmud99MT0RigKvjJPSBA
        UQxaIioMEjCqH9DtQgZc+m1emukf6zelgQ==
X-Google-Smtp-Source: APXvYqzssrQFGC8tjNWJ9ZZAgIgrjrXWpGINQljKB370KnHsO2VhTsitycAXppKdlGPKP12Ucwltfg==
X-Received: by 2002:a7b:cd12:: with SMTP id f18mr951713wmj.111.1567536685393;
        Tue, 03 Sep 2019 11:51:25 -0700 (PDT)
Received: from [10.230.33.15] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id f13sm17958286wrq.3.2019.09.03.11.51.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 11:51:24 -0700 (PDT)
Subject: Re: [PATCH 0/3] brcmfmac: keep wiphy during PCIe driver lifetime
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Winnie Chang <winnie.chang@cypress.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20190903042928.18621-1-zajec5@gmail.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <251e608a-c311-3827-02cd-886c8403f7ec@broadcom.com>
Date:   Tue, 3 Sep 2019 20:51:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903042928.18621-1-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 9/3/2019 6:29 AM, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Driver's main init/attach function brcmf_attach() was handling both:
> wiphy allocation and driver initialization. It meant getting a new wiphy
> on every init (initial, resume, error recovery).
> 
> For supplicants/authenticators and Linux users it's move convenient to
> have the same wiphy over driver's lifetime. It allows e.g. automatic
> recovery after a firmware crash.

Typo: 'move' should be 'more'.

Regards,
Arend
