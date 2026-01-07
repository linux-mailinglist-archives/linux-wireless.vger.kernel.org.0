Return-Path: <linux-wireless+bounces-30512-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E0FCFF99B
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 19:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75AA830E9420
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 18:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5353F2D63E8;
	Wed,  7 Jan 2026 18:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="HYBaXROd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nike2uT1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E6A350A02
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 18:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767809609; cv=none; b=O7syDK5dOYFOPKHpX14qLuTSbcGS4LmXEtKanHQG9F+7v+CMMKF4QodJvLXReUKzduG93A/ESm9kUmTVBaz72u7aUzkoSvL44bOWjR966i5faHmafQ7aBAWK1cCA7oAVo9Mm8kvBRbH10L+pOwhiipph+a5MrNDmpcrPlSY06WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767809609; c=relaxed/simple;
	bh=JS2GlGJsPG9S1//MOHUCtKs8Z9fK/lPMduoQSO3jY5Y=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=rO2tWXAK1xj2We8tSRnlKdS5gQkjz/twYL2BLbeiiHCUVfS8EKTBKQkoPkFEeKPQBX3co0c1gzSAA+lbQ3owcx4i3sNI+hsEm478dpfGiPsFxuznyP4FlXkOqBJjfxLRFbC0OOucoGlV7isJWDFg67Vs7gi4ocPRMAVGEZ0foAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=HYBaXROd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nike2uT1; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id D4C16EC0333;
	Wed,  7 Jan 2026 13:13:25 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-02.internal (MEProxy); Wed, 07 Jan 2026 13:13:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1767809605;
	 x=1767896005; bh=ZrZskx9vrgBES4oPwII0k8unlMuYBRuRXEAKy3ZhCuc=; b=
	HYBaXROdkunJWZvjBNC4WPI089TK5jpJ8+SPS3jO1FaJOz7c1wBSweV0Cge2X5KQ
	fjnqEdeul0hocssh9dOGKGo78iiUxrC3xZaKn22pcUm1JAIid7QZtjsBJFEypaLH
	y2y5HMfwAQl1tN+2PAZQVmYNk34kvN8ZK38ZHjbhRuC1skI93gO132dxfyrNRUCW
	X9WXigOnqcimKDqKxa+kR0Gm8+FdXbm1oBxW/cHvA+AOCPxEIVAJnEkNrwkoaVJP
	x8Kqw4W72zAjfA+YxJ/9JBBaW+3A6VQYl2mcp8oNqJQgK4E35ZDFjEdGmiSc0oXm
	FcvhMRFXBWb9htrpOI9N/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767809605; x=
	1767896005; bh=ZrZskx9vrgBES4oPwII0k8unlMuYBRuRXEAKy3ZhCuc=; b=N
	ike2uT16M7R3Iz8l94WU2cX6euffp5QB2VPITDEphWQPnx/edbQ6tyWZ6wqhkXJ+
	IoktNQGkEAqL6lrl7LuV1N5uFbYr+G7TSEVKRswz3u+pdtWzET/x3kO9oKzqFgKP
	1EaklSQ5hamTm0JYyGLERgOTAhPTFxMtlek11Av0AxoZTJsZ/tDER8NecJb1GuYi
	NRkpRaqOiTWAUBvHh18cyG38C9I1dGtABvva+FbpGxebPX7Nc0oVOgFvfapxzNbH
	ENRSyd//TKxp/ByBgMzMgdYt+29A+NBREDzepDCNh3rjAz+5Ub0BWU3x9dhGDgj3
	ZwZN1lJslyYO/9fPUxM+g==
X-ME-Sender: <xms:RaJeaStI_pF0UAR2NiGSUPd9N_u_CGQ_o28RgQeGqIgdvKYpO0yiLQ>
    <xme:RaJeaSQwTktjkUL93m07IDnp8-BtNx1-H_48Sf_w59_0nJUuH0VkLIMI3kWIqQodE
    CM0GLZT8Q6c2aVBeahB4sbqemB6yX1Og23uVACEbTY_8Hl1Q1NVNBM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdefjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfofgrrhhk
    ucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtg
    grqeenucggtffrrghtthgvrhhnpedtffevgfethfevteduvdefleevkedtuddvlefghefg
    ieekffejteejveffkedthfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhpvggrrhhsohhn
    qdhlvghnohhvohesshhquhgvsggsrdgtrgdpnhgspghrtghpthhtohepgedpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtoheprhhoshhssehkrghllhhishhtihdruhhspdhrtghp
    thhtohepjhhjohhhnhhsohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrthhhud
    dukheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhig
    qdifihhrvghlvghsshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:RaJeaY0LkARX0etxX8RIEVaURS5SL8f1OUtX79pUCf08ljEqZPoBfw>
    <xmx:RaJeaejmR5b83mXAt31tmXPSyAznh6oUkO-D-jQSPy41yi6gD46zUw>
    <xmx:RaJeaUbU3CvBItD8eFDxVv3yFNlJZUaa70DgzjqRQYS3UX26YTy1AA>
    <xmx:RaJeaWQscpObQ5jgORm7a4YefB0QmL5Ul7ATuBYII9jaOeARC-apQg>
    <xmx:RaJeaeb2DK0w7WgJI99XkO1mmHG7sYnT-2-URNOyKbFkoJM7P0R0501h>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9678B2CE0078; Wed,  7 Jan 2026 13:13:25 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AmQXQaeoO3KB
Date: Wed, 07 Jan 2026 13:13:04 -0500
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Ross Vandegrift" <ross@kallisti.us>, "Jeff Johnson" <jjohnson@kernel.org>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Message-Id: <b6b3255b-69bf-40a3-b80e-22b57f3e18d0@app.fastmail.com>
In-Reply-To: 
 <wj7o2kmb7g54stdjvxp2hjqrnutnq3jbf4s2uh4ctvmlxdq7tf@nbkj2ebakhrd>
References: <wj7o2kmb7g54stdjvxp2hjqrnutnq3jbf4s2uh4ctvmlxdq7tf@nbkj2ebakhrd>
Subject: Re: [PATCH v2] wifi: ath11k: add pm quirk for Thinkpad Z13/Z16 Gen1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Jan 3, 2026, at 8:00 PM, Ross Vandegrift wrote:
> Z16 Gen1 has the wakeup-from-suspend issues from [1] but was never added
> to the appropriate quirk list.  I've tested this patch on top of 6.18.2,
> it fixes the issue for me on 21D4
>
> Mark Pearson provided the other product IDs covering the second Z16 Gen1
> and both Z13 Gen1 identifiers.  They share the same firmware, and folks
> in the bugzilla report do indeed see the problem on Z13.
>
> [1] - https://bugzilla.kernel.org/show_bug.cgi?id=219196
>
> Signed-off-by: Ross Vandegrift <ross@kallisti.us>
> ---
>  drivers/net/wireless/ath/ath11k/core.c | 28 ++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/ath11k/core.c 
> b/drivers/net/wireless/ath/ath11k/core.c
> index 812686173ac8..03dddc1cd003 100644
> --- a/drivers/net/wireless/ath/ath11k/core.c
> +++ b/drivers/net/wireless/ath/ath11k/core.c
> @@ -994,6 +994,34 @@ static const struct dmi_system_id 
> ath11k_pm_quirk_table[] = {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "21F9"),
>  		},
>  	},
> +	{
> +		.driver_data = (void *)ATH11K_PM_WOW,
> +		.matches = { /* Z13 G1 */
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "21D2"),
> +		},
> +	},
> +	{
> +		.driver_data = (void *)ATH11K_PM_WOW,
> +		.matches = { /* Z13 G1 */
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "21D3"),
> +		},
> +	},
> +	{
> +		.driver_data = (void *)ATH11K_PM_WOW,
> +		.matches = { /* Z16 G1 */
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "21D4"),
> +		},
> +	},
> +	{
> +		.driver_data = (void *)ATH11K_PM_WOW,
> +		.matches = { /* Z16 G1 */
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "21D5"),
> +		},
> +	},
>  	{}
>  };
> 
> -- 
> 2.47.3

Tested on my Z13, and works well. Unfortunately my Z16 is dead so I couldn't sanity check that - but code looks good.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Mark

