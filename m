Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB331377F59
	for <lists+linux-wireless@lfdr.de>; Mon, 10 May 2021 11:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhEJJ20 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 May 2021 05:28:26 -0400
Received: from relay.smtp-ext.broadcom.com ([192.19.11.229]:40852 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230291AbhEJJ2V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 May 2021 05:28:21 -0400
Received: from bld-lvn-bcawlan-34.lvn.broadcom.net (bld-lvn-bcawlan-34.lvn.broadcom.net [10.75.138.137])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id EDE0A2433B;
        Mon, 10 May 2021 02:27:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com EDE0A2433B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1620638836;
        bh=Pao7WJbZ5nJQTVvUCk0YPJC6pu49mOg3w5lS0cwckFU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WfDoxvLQgWW6QlFUTk3bL65XKlWrmP1znsaLEWbh4dc2+zaP4XUvTNpVxvae/I3IW
         YoHX38nXr07MCMvyLl2TwuKOv0WG/Kb+M6YmO/g2khXaER11BYnhUA4zTNUDE+9fyG
         peu90nSFf9E658979edZb2sevuSdNF9YF/eVimoY=
Received: from [10.230.41.67] (unknown [10.230.41.67])
        by bld-lvn-bcawlan-34.lvn.broadcom.net (Postfix) with ESMTPSA id 010111874BE;
        Mon, 10 May 2021 02:27:13 -0700 (PDT)
Subject: Re: [PATCH] brcmfmac: Obtain reset GPIO
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <20210509224226.348127-1-linus.walleij@linaro.org>
 <c5370b69-eac2-815e-27cb-f865a7885830@broadcom.com>
 <CAPDyKFq6PEx9YNF5VDjEy2giLOe=NJPxM2KCAWOOQxeGR_3jMw@mail.gmail.com>
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <30a7bbeb-d588-4780-bd6c-d99f72898138@broadcom.com>
Date:   Mon, 10 May 2021 11:27:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFq6PEx9YNF5VDjEy2giLOe=NJPxM2KCAWOOQxeGR_3jMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 5/10/2021 11:14 AM, Ulf Hansson wrote:
> On Mon, 10 May 2021 at 09:37, Arend Van Spriel
> <arend.vanspriel@broadcom.com> wrote:
>>
>> + Uffe
>>
>> On 5/10/2021 12:42 AM, Linus Walleij wrote:
>>> This grabs the reset GPIO and holds it de-asserted, if available.
>>> Asserting this signal will make the SDIO card re-enumerate.
>>
>> looks ok to me, but could this also be done through SDIO power sequence
>> stuff?
> 
> Yes, it certainly looks like that to me. It should be the mmc
> host/core that manages the power on/off thingy for the SDIO card.

Thanks, Uffe

This is not directly power on/off, but a separate "reset" GPIO. However, 
checking in pwrseq_simple.c I see:

struct mmc_pwrseq_simple {
	struct mmc_pwrseq pwrseq;
	bool clk_enabled;
	u32 post_power_on_delay_ms;
	u32 power_off_delay_us;
	struct clk *ext_clk;
	struct gpio_descs *reset_gpios;
};

So the term 'reset_gpios' is also used in pwrseq context.

Regards,
Arend
