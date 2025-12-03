Return-Path: <linux-wireless+bounces-29463-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D74D4C9D87E
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Dec 2025 02:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9273D4E5016
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Dec 2025 01:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5C922DF9E;
	Wed,  3 Dec 2025 01:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="18miu3LF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3594322FE0E
	for <linux-wireless@vger.kernel.org>; Wed,  3 Dec 2025 01:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764726723; cv=none; b=PC+6gsRe1Li7fw+B0b9545VqgdizVHckt56t9QCqeQ3wnfsr+P+8wB/D/Szq7r7cEv30ZbCzFcfeT0l2mC2FqmQma2SXorQGliCtN/t7LZrW+vb/bjh2hS+Tfwaa6M/aykEM1MdRpG8LU5DOda2XG3iJcsQwoohFtNCsWueCb5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764726723; c=relaxed/simple;
	bh=8MeiogLzYWhzpQ9LR0wknPUpZvjFmTSpu3YnlYwa3SU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TA6BWUi7GNm4vq0QMGs7JqWcewZxr1bbAQOvNDFo2F4TCpScDOzIB96d60HfXi4IyL7/GK1TOK29JgKeUKMKuayIigCd6wYZlV/wKUdE1Y4I5mEuEj58vTkwQOyq7WKckqu8HZRiYaIQwW4W+Q5fA2FPyzki/9YpAv5RA+AAKbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=18miu3LF; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3437af8444cso7259376a91.2
        for <linux-wireless@vger.kernel.org>; Tue, 02 Dec 2025 17:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1764726720; x=1765331520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AloyWb9XluZcdyh359j2saJyNSEQkJKTeXcpCLM57Kg=;
        b=18miu3LFX8fovk+p0k8Z72dNWGIKqmHBM0Kei/BewfInm+Lt346U6IfxiP+yiMdIgF
         DEEbRchjjEgcZAFuIuDeeGcZX0wXne6/Zfrbwi00JiT13wSXgsC1RFTwYh6XT4iNKBGv
         jBcXUfjoTTlrL5b/+EduVmtuhT41P75lYVlCWpS4y/Py9SlBk9khjivv+u4Ww2xatizZ
         cEXGsa4GyDv71T02Yo2WuqYEGeZRms5PZe/9IMVj4hQ2UBme9rTdT5igV9BA/KGCplwJ
         3BiRynDQk4KUsfxaKJn7XabcjW3El6mnw+BvE2omeaNloPqz0YjWyUKThxV/30dOle87
         nxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764726720; x=1765331520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AloyWb9XluZcdyh359j2saJyNSEQkJKTeXcpCLM57Kg=;
        b=EAhgKpJ+4QI8Q657ib6GPONDthxlzRhjy2flYJ3oKiI9hJxa2dPfU6Y0NoVgMunDa6
         m7eQlymuNbT5B5dufkx/dMwjA31UeqrnhR9xXO76qGTuXQ9GEQBmE8z4QoB5/k9/xGk2
         xZoeXP+thGXz/qGAzVuIUz3XwoU9Q6k7dmcPAteShPe3Tnd9UR/l9UBdzkjZS+vsyOtl
         f48CILUrMMhZ6Cpf+G935lPN5LJbWZeehrnXSWll2OB/6FVwTRsbslrsFJfh0n47Zqmw
         UPeBymhxOKCogwYAF5oBmuB2yAdjVOip9HD0zYCkj/ACAD8U8nTrC1tpfOAEpC8NZkab
         30ow==
X-Forwarded-Encrypted: i=1; AJvYcCWrPFxqLCitsLCUi6ymmmHgB8Nid6Vactw0WidAAACdMHrJdM+zZHhDKY1PJ6qqdUYIFli21arroCRJCd+2Wg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ17cp4zdPG5l6+CKZxGPFef6up1iMEGAnWA7EzlaO6v6g1Zfa
	KYiUhBLWd3uEW0lMl8d5DP/fBaEUaztKX/VyX2tlvOOqG4WcY6AePU9ZWwzP0uxwTkadCnzC2c9
	lvRrf
X-Gm-Gg: ASbGncuJcvujh3pu2GfFRbD+HskYUt48xDtz4pQqoktRHnMnopYSaDXR9DzHK8bPUZv
	hMNQLEzkCcbjRPWeeYQtazr3ESUBgpswWDO1r5aUFqFaqRMR+E2z06RyzSRrfFPMyRETuwQJJEf
	jnw8bWQZ9oHvR9vYyoh1yDg7tU/a9EDBi0hlbuszaEXcHnYsAk0cmCx2xaJ3gwLIXvM7KpyJ3Yb
	VAOUKJlXSAlHzTG1/l2Dlvgaaj4lTKuydfVMULqDBbesrm9t4/CKxH3aleJMulyPPTxvg36W9O/
	FgrpXyXtH5sIm8uWzejrhI1HTE+BIJGANDdt9JaVPVuIXQbk7guyKYORrEWS6xn7On8ZwN+1KaV
	lChfX4bNVHGFbwV/+lKzw0CayPUyJv8unevXGRotLEMl0XhP9kA3jOkvu+85r2m1RY/qz2obsaD
	69ZdqIjj7DiKuPy/hhVK0eEOwAsC0TFXxEE1wFsHOLX2ioJpGVg/LsL3jQsAUWHY1oPCHA3KsC8
	SeyYmGKNAg=
X-Google-Smtp-Source: AGHT+IF28jSP3f6HAlUsETaR7all4L8LWet/Vw+UV3vS15H9K23dYShXa0kyjZAOT81cvzGhtnzJUA==
X-Received: by 2002:a17:90b:6c5:b0:349:1597:5938 with SMTP id 98e67ed59e1d1-349159759cbmr14925a91.23.1764726720394;
        Tue, 02 Dec 2025 17:52:00 -0800 (PST)
Received: from localhost (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34912897600sm204590a91.0.2025.12.02.17.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 17:52:00 -0800 (PST)
Date: Wed, 3 Dec 2025 12:51:56 +1100
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Jozef Marko <jozef.marko@globallogic.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, 
	linux-wireless@vger.kernel.org
Subject: Re: wifi: mac80211: Kernel Panic (Null Pointer Dereference)
Message-ID: <ah3ymjghwpuzokny2ohpdh65ofce6chxkf54czp2aqo62p7xyj@scevhxsfpqt7>
References: <CA+Fox+xtL17pYJkDJ5Dob+VyRUe9h7hrR8=VHcJB1ZQHA89-5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+Fox+xtL17pYJkDJ5Dob+VyRUe9h7hrR8=VHcJB1ZQHA89-5Q@mail.gmail.com>

Hi,

On Tue, Dec 02, 2025 at 04:46:49PM +0100, Jozef Marko wrote:
> Patch Justification:
> The original code unconditionally set new_chandef to the reserved operation
> (&link->reserved.oper;) if reserved was true.
> The patch adds a crucial check: If reserved is true, it assigns new_chandef
> = &link->reserved.oper; as before.
> The Critical Fix: It then checks if the channel pointer inside it
> (new_chandef->chan) is NULL.
> If new_chandef->chan is NULL (as confirmed by the original crash's address
> 0000000000000000), it indicates an invalid channel context, which would
> cause the subsequent crash.
> If the reserved context is found to be invalid, the code triggers a WARNING
> message and re-assigns new_chandef to the non-reserved, requested channel
> definition (&link_conf->chanreq.oper).
> This fallback prevents the NULL pointer dereference and the subsequent
> Kernel Panic.
> 
> *3. Log with Applied Patch*
> 
> Result After Applying the Patch:
> The attached "*BPI3_hub_chan_switch_crash_protection.txt*" log with the
> patch applied confirms that the error scenario was hit, but the Kernel
> Panic was successfully avoided. Instead, the custom WARNING message was
> logged:
> 
> WARNING Message:
> 
> [  209.602618] NULL dereference crash protection reserved new_chandef->chan
> = 0000000000000000
> [  209.610978] WARNING: CPU: 2 PID: 551 at
> ieee80211_iter_chan_contexts_atomic+0x2d0/0xf5c [mac80211]
> 
> This message, inserted by the patch, confirms:
> A state was detected where new_chandef->chan was NULL (value
> 0000000000000000), which would have caused the original crash.
> The crash protection mechanism triggered the warning and switched to the
> backup channel structure, successfully preventing the NULL pointer
> dereference.
> System Behavior: The system did not panic and continued execution.
> Subsequent log entries show further operations, confirming system stability
> was maintained.
> 
> Conclusion:
> The proposed patch is crucial for addressing a NULL pointer dereference
> vulnerability in ieee80211_chan_bw_change related to improperly formed
> reserved channel contexts. Its application prevents a system-critical
> Kernel Panic during dynamic wireless operations.

I don't think the idea of inserting a WARN as "crash protection" is the right
approach. It would be more worthwhile figuring out why chandef::chan is NULL for
the reserved chandef while the reserved argument is true within
ieee80211_chan_bw_change().

lachlan

