Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8AA18EDBB
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2020 02:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgCWBvv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Mar 2020 21:51:51 -0400
Received: from mxout017.mail.hostpoint.ch ([217.26.49.177]:64481 "EHLO
        mxout017.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726954AbgCWBvv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Mar 2020 21:51:51 -0400
Received: from [10.0.2.45] (helo=asmtp012.mail.hostpoint.ch)
        by mxout017.mail.hostpoint.ch with esmtp (Exim 4.92.3 (FreeBSD))
        (envelope-from <code@reto-schneider.ch>)
        id 1jGCFm-000GbV-0R; Mon, 23 Mar 2020 02:51:46 +0100
Received: from [2a02:168:6182:1:a8e7:613d:a871:7d4b]
        by asmtp012.mail.hostpoint.ch with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3 (FreeBSD))
        (envelope-from <code@reto-schneider.ch>)
        id 1jGCFl-000P4w-UX; Mon, 23 Mar 2020 02:51:45 +0100
X-Authenticated-Sender-Id: reto-schneider@reto-schneider.ch
Subject: Re: [PATCH] rtlwifi: v88 firmware files for rtl8192cu
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org
References: <20200320025229.12084-1-code@reto-schneider.ch>
 <83d9a5bb-7802-2fa4-ffff-df318f8ce0e1@lwfinger.net>
From:   Reto Schneider <code@reto-schneider.ch>
Autocrypt: addr=code@reto-schneider.ch; keydata=
 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
 aAip+kZx5NKqIG/9jy36pw==
Message-ID: <f38d2640-940e-5cef-4f5e-026387bd2bd3@reto-schneider.ch>
Date:   Mon, 23 Mar 2020 02:51:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <83d9a5bb-7802-2fa4-ffff-df318f8ce0e1@lwfinger.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/20/20 5:00 PM, Larry Finger wrote:
> New firmware should be sent to linux-firmware@kernel.org, not
> linux-wireless.

For some reason I had a look at an outdated linux-firmware README.

Did and will CC linux-wireless because it is written in the README -
also in the most recent version.

> The material in the first section of this E-mail
> regarding the derivation of the new firmware should be added to WHENCE
> in the linux-firmware directory when you git clone
> git://git.kernel.org/pub/scm/linux/kernel/git/dwmw2/linux-firmware

I will post a new patch with this changes.

> File rtlwifi/rtl8192cufw.bin is loaded only when the initial firmware
> file is missing or cannot be obtained for some reason. Ideally, it is
> never used, thus you can skip updating it.

What would constitute the initial firmware? One of the updated three
files? Something that is stored on the chip itself?

Reto
