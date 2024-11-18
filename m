Return-Path: <linux-wireless+bounces-15448-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F619D0E9C
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 11:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A75E0282501
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 10:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78750194A51;
	Mon, 18 Nov 2024 10:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4k1UcL1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F786192D80;
	Mon, 18 Nov 2024 10:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731925973; cv=none; b=N7rh1bgSeVScYHmtHNZASf1NsPAJ7JR9ANO9B5YAt2IbBYM6NXJNO7zM0QnwEiP2NFaWUeKX6j7oyu22C8QqT4MAxn+uzpeKNJu0QTa09ULDH5WIbspfRM/2LFKyMrfjrQsJYQoPXuKNmFLEAVU7z/ZMifaklQhrCRmWV1EYsak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731925973; c=relaxed/simple;
	bh=gWLzkKe3yBOjSr8ApJffbNKdP5Ok7maJbYZ3l2VWFzE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=iIIueMldn6+/2xajSBULaX5X3wa5oOClqoZuKHXgpXbM2DDCAnDlAUq5g9epdbpb5yHI3wbp/5CQvgQA9gHQW6CrefM7SrjMsym9yHvufq/I4LXIjocvxuFWbnQWNYTKv0Lz63QGVfO/6hsjzy/Zy5kZcEaWZCrrQrXz8P7j4Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4k1UcL1; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43167ff0f91so25721055e9.1;
        Mon, 18 Nov 2024 02:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731925970; x=1732530770; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sXn9Mp5THOoB4QUhlxb6xYALkb/wxlQgOoJvivddYJ0=;
        b=B4k1UcL18s/QVVyd2Awr9xRvhOGgttKWZTrGNkHisbACDzlw8NzMmQCXz3tsnYdjuU
         2nSYJBdEpt4jjMWY9D9VdZTlZmArXjOkleHsBp4XAXBRE2EYINwwkSk+zvFmrW3He4bO
         SQkUAG77oqhOR+szHlYAQjDYJS0aIt2sKUBvUFiAIpxQ9SrrhXDdEQgixkwqCHfZTdO3
         81BuhLZMRL9GLbKI9TXgCuZDVmK50H6pnwoBHV6x6QXiZbC6O/D1sFo0acFnGq1McJSa
         V4GIl7ijdDVVoFmij/FQP3tY08g4n61Pi8yKWclUo9pLZrjhV2/ap9XkH9KZDYMPy6wg
         RY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731925970; x=1732530770;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sXn9Mp5THOoB4QUhlxb6xYALkb/wxlQgOoJvivddYJ0=;
        b=rQePg6TbVCOkLPTqkEioFGOHpEJ+EvBMiS6vDvUnZXW+MRXmlKuKDZ1SoyNRscQ+z3
         GS8X4JDCe4OJcL7wvAfJyb9eahWPaDR1bRu16m3xM/4TPFmNucK8QokXKhg9jj/ssw/l
         mTi7qNURW9jiB6PP07TSnzfjKX5AqUu/BV8+pzY9LWBNPcjz+iKPkwNZ9mG3B3gluecb
         o9Lz1kvi/iotFnd9i7stcHr2gCRtegLGGy/cCNgoJJAnKMzrKSS/wLzKqd/lsWJiq0/i
         Wpo7rvSnaCGst/qiQ9nY9reZfv331VcdJDw13OwK5JomiBz8nONxr9SVfUQxf2NsPEWz
         M1mg==
X-Forwarded-Encrypted: i=1; AJvYcCWJlh4x48z2EpWglpRHtrY+1oXZRHLgN7iRHo5oVolxTGTTOMmE++sH96PNpzBWh0y/SkoThTQpaZWNxYYZ+g==@vger.kernel.org, AJvYcCXl0SUvJJ46S2pbNonsgWGqpKkmzms066s+4OUijfZQfPWVDNErG+sTlpYbrYN57O/+7LKKu94PF4hTGJQR6WVJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxU8BfEyqaTioGfuqu02PytqS3/yTUvqLVrJBYkPBLvdO+CsbPt
	8z7BHa9yo+m3/+ywf8yXeLHpoE3026c3Kz3ek2HMFXWWku9Z6tA6py6YXw==
X-Google-Smtp-Source: AGHT+IGMZCLEQ4H1S3ifcXM7+c7qdvm3S0RsbsRMkcS1ZOXoJduf/i024yQ3orBm+5uoTd396DiOxw==
X-Received: by 2002:a05:600c:34d2:b0:426:66a2:b200 with SMTP id 5b1f17b1804b1-432df676328mr103076875e9.0.1731925969691;
        Mon, 18 Nov 2024 02:32:49 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ae161d8sm12629064f8f.78.2024.11.18.02.32.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 02:32:49 -0800 (PST)
Subject: Re: [PATCH net-next] net: reformat kdoc return statements
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 pablo@netfilter.org, linux@armlinux.org.uk, richardcochran@gmail.com,
 johannes@sipsolutions.net, loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
 dsahern@kernel.org, wintera@linux.ibm.com, hawk@kernel.org,
 ilias.apalodimas@linaro.org, jhs@mojatatu.com, jiri@resnulli.us,
 przemyslaw.kitszel@intel.com, netfilter-devel@vger.kernel.org,
 linux-wireless@vger.kernel.org
References: <20241115163612.904906-1-kuba@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <3c75efb4-dc04-ebad-ce1d-98bcc6569c84@gmail.com>
Date: Mon, 18 Nov 2024 10:32:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241115163612.904906-1-kuba@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 15/11/2024 16:36, Jakub Kicinski wrote:
> kernel-doc -Wall warns about missing Return: statement for non-void
> functions. We have a number of kdocs in our headers which are missing
> the colon, IOW they use
>  * Return some value
> or
>  * Returns some value
> 
> Having the colon makes some sense, it should help kdoc parser avoid
> false positives. So add them. This is mostly done with a sed script,
> and removing the unnecessary cases (mostly the comments which aren't
> kdoc).
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
...
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 0aae346d919e..ed549a2e02b2 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
...
> @@ -3548,7 +3548,7 @@ static inline void netdev_tx_sent_queue(struct netdev_queue *dev_queue,
>   * that they should not test BQL status themselves.
>   * We do want to change __QUEUE_STATE_STACK_XOFF only for the last
>   * skb of a batch.
> - * Returns true if the doorbell must be used to kick the NIC.
> + * Return true if the doorbell must be used to kick the NIC.

Think the colon went missing here.

>   */
>  static inline bool __netdev_tx_sent_queue(struct netdev_queue *dev_queue,
>  					  unsigned int bytes,
> @@ -3802,7 +3802,7 @@ static inline bool netif_attr_test_mask(unsigned long j,
>   *	@online_mask: bitmask for CPUs/Rx queues that are online
>   *	@nr_bits: number of bits in the bitmask
>   *
> - * Returns true if a CPU/Rx queue is online.
> + * Returns: true if a CPU/Rx queue is online.
>   */
>  static inline bool netif_attr_test_online(unsigned long j,
>  					  const unsigned long *online_mask,
> @@ -3822,7 +3822,7 @@ static inline bool netif_attr_test_online(unsigned long j,
>   *	@srcp: the cpumask/Rx queue mask pointer
>   *	@nr_bits: number of bits in the bitmask
>   *
> - * Returns >= nr_bits if no further CPUs/Rx queues set.
> + * Returns: >= nr_bits if no further CPUs/Rx queues set.
>   */
>  static inline unsigned int netif_attrmask_next(int n, const unsigned long *srcp,
>  					       unsigned int nr_bits)

I agree with Johannes here, it ought to be something like
 * Returns: next CPU in mask, or >= nr_bits if no further CPUs/Rx
 * queues set.
but understand if you don't want to include a semantic change in
this mechanical reformat patch.

> diff --git a/include/linux/phylink.h b/include/linux/phylink.h
> index 5c01048860c4..fe0d005cd5d8 100644
> --- a/include/linux/phylink.h
> +++ b/include/linux/phylink.h
...> @@ -464,8 +464,8 @@ struct phylink_pcs_ops {
>   * mask. Phylink will propagate the changes to the advertising mask. See the
>   * &struct phylink_mac_ops validate() method.
>   *
> - * Returns -EINVAL if the interface mode/autoneg mode is not supported.
> - * Returns non-zero positive if the link state can be supported.
> + * Returns: -EINVAL if the interface mode/autoneg mode is not supported.
> + * Returns: non-zero positive if the link state can be supported.

Does having multiple 'Returns:' sections in kdoc work?  I think the
right way to write this is
 * Returns:
 * * -EINVAL if the interface mode/autoneg mode is not supported.
 * * non-zero positive if the link state can be supported.
(Although I'm not sure about the accuracy of this documentation; it
looks like the calling code only treats <0 as error, and several
implementations of the method return 0 in what look like success
cases.  So that "non-zero positive" looks sus.)

IDK which part of the patch got me on the CC list but fwiw you can
add my
Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>
for the whole thing to v2 with the double-Returns fixed.

