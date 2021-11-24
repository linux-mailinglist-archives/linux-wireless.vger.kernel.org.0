Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D0E45C727
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Nov 2021 15:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352088AbhKXOZA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Nov 2021 09:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356369AbhKXOYY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Nov 2021 09:24:24 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFF5C0619FB
        for <linux-wireless@vger.kernel.org>; Wed, 24 Nov 2021 04:50:09 -0800 (PST)
Received: from mail.denx.de (unknown [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: festevam@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 9546582FA8;
        Wed, 24 Nov 2021 13:50:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1637758205;
        bh=zbYWMVyBGaGWXHJvm/teZQMBCLTITZf7ywToqsz9XHQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=llm55hIdAPJDCRRqtFBfGRz8e9G6DsTg9u695E6ZCT7sL1U4ivKqu30WH2uL1uwS8
         j9VkjszKmEuAoNkflWWGvC0Niy2FWhUA4aoNnfCZXInI0eb5fQH57O8Uc/V02gMfFx
         EfJX+cdu3JoCmZTG18lfgApQ+6qzye49Woor5mKgX2VWpCqCkhxkUWpPQd8UCgoUKA
         jx/hH81xSxS/rEBM6PPFTbnAnjGMa+gn4Ohpla/GMeSpz90I9fLb2B9JLVuWZi7Ihe
         bdRanFmQv7slJ5VtDd+zg1c/liAw6XOVtZ4MLYbeA9mjgAFrjJxh7NyS0mfx2u10Ps
         foxNws4sAPM2g==
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 24 Nov 2021 09:50:05 -0300
From:   Fabio Estevam <festevam@denx.de>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Wen Gong <quic_wgong@quicinc.com>,
        Fabio Estevam <festevam@gmail.com>, ath10k@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        erik.stromdahl@gmail.com, alagusankar@silex-india.com,
        kvalo=codeaurora.org@mg.codeaurora.org
Subject: Re: [PATCH] ath10k: Clean the HI_ACS_FLAGS_ALT_DATA_CREDIT_SIZE flag
In-Reply-To: <87a6hu6ksf.fsf@codeaurora.org>
References: <20210915160422.2839595-1-festevam@denx.de>
 <CAOMZO5AYUxJg4bWudT3L1P=qNR2UBcNR1zmjCf5O9_ExyPw4ww@mail.gmail.com>
 <CAOMZO5AJ8q06YTHP=p84nJnKOYU+=MKVqJ3qz3XnUGcAg0xo=g@mail.gmail.com>
 <87ilwi6lo4.fsf@codeaurora.org>
 <5dc61605-2ada-3c0b-64de-ea16ad31efbc@quicinc.com>
 <87a6hu6ksf.fsf@codeaurora.org>
Message-ID: <12399c734dbe4867d1ea4569a192ecb6@denx.de>
X-Sender: festevam@denx.de
User-Agent: Roundcube Webmail/1.3.6
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle and Wen,

On 24/11/2021 05:05, Kalle Valo wrote:

> Thanks, I was worried it's something like this. One way to solve this
> would be to add a new field to ath10k_hw_params so that the workaround
> is done only on QCA9377 SDIO.

Thanks for the feedback, appreciate it.

I have done as suggested in v2.

Thanks a lot,

Fabio Estevam
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-60 Fax: (+49)-8142-66989-80 Email: 
festevam@denx.de
