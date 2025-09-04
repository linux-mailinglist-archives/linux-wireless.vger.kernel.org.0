Return-Path: <linux-wireless+bounces-27000-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B18B436F7
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 11:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F4C71C271EA
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 09:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D032EF643;
	Thu,  4 Sep 2025 09:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pq0rgn7J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3522EF65A
	for <linux-wireless@vger.kernel.org>; Thu,  4 Sep 2025 09:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756977793; cv=none; b=t2d9tZ/tJNaRGB85HxzeqAqHrkdZRPEp/uL+AkudGZ2x4wHPX09Btjng5pBzKSRWqYgjW/wFIn99OSbp0cctkRYXxW6uQK2nC7O0H32VlrLwmKfIMHsMmgRcZsx6XS41fuVODpzimpIXf1a9R/iE1rfuSDmeBigGZ72cf84S+/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756977793; c=relaxed/simple;
	bh=7V4JK1T+TM14aaVL4s82TwxFYw6Snnv3+YNVGDwaoFI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=osTEINfJ63AyruvIeRh8xd3DdW6riHL07QT7WyCaZlRETaGEq0vK9ZcH2esPF0fzfmhylbQyoxfJzsh0LfBlwRPfRrGLc1+rh7PhZDP/BFnhvrH4hlTKNBPvRtxNrwKjqPdsyfm3xP3+sAB7LQNSUSL9GwSpx/LPwW6FrGILwdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pq0rgn7J; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45cb6180b60so5245475e9.0
        for <linux-wireless@vger.kernel.org>; Thu, 04 Sep 2025 02:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756977790; x=1757582590; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zx83lTm+FDte02e3FppN05MIMP6Z5zqC3JMzyNUwq3E=;
        b=pq0rgn7Jg9uhktQiUZlLVS7IKeb1thixJBBYnOwgnoS9zkF+i6gsqI27l7TookROSP
         0oyWKhdV4cUht6XhzoYIFyl3LE3gH+IVNo3U74vOLEoe9vyF1RA7wW5BNA3AWju+twBj
         P/q2h8EgOSz+lXpE9LSlyt61zLn+UD6p0c4AH86ik2Xd3Uk0OvaGOBXusgVVeeD772lC
         5Ee2IXDofmc5H/gSHkXD8iQhbx0CI6UlRSBpxY1t4EB+1vx81UshKO/VjGtSWo+sBgq+
         tIDWFK/VXg5H8IFcSm8F9vUyLwOK5Iia6eox5ASDEVfkYO3kjQIU9Bj2nsm7NGHNMZgb
         xS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756977790; x=1757582590;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zx83lTm+FDte02e3FppN05MIMP6Z5zqC3JMzyNUwq3E=;
        b=Coiu4Z5vN436jqZUje+7NJcEZpn1rulonoFb1naeL+AezOomZr0u1TyTWkYAOOpUw5
         YOq0Zuwcky1xmT2COQjKcJVkRfej36xpzemPGMsghRiqmyuambnj1SnVy7LOYvVa/sGA
         YEGojqY0yWmpLzRekxAHvbRRzSwiKyTmCr0syYwkQxSsR0nViJfcpk5qbuzz/bCe0CSh
         fsWnM9+HnIyhWK+Z4GVnP+hqkNoTqXc0gGjCYcRmsSJXudNx8CpovWzTWAd0aBhITg3s
         G249+6sC97vdg5f6L4aWVxUX80gxyBQUTSe4G2DEBjejH6mtpsXw4VSW636zMH21RsLK
         ONGw==
X-Gm-Message-State: AOJu0YyU9TKFR/fAP9i6HtIVGCs2k2E8pquiLLVUPyuJr2U4fgFkic3h
	aICqwkp6P9X7Q5PqyzS+gBAeghWX268fVPBA+zcH0p55XZodjzgUVbHnHUTlVZcvh4c=
X-Gm-Gg: ASbGncuuQaRN/Xnr+8nkcERxCooTXAP+fa/Sl5nq0yVohaPwlOHBKfTrMvS+x2l5aUR
	Hd6wGLgoDORIzHRkhZRuP/lK2zPuCHAIRP1de6pYJHe9YPCAVgR3yTlC89tw60Rg7F1Q0v6pjng
	W100TUIRzFeiOOaWcsZBw5pW2kp4m0jzWwhQRkEkOQabs39nS8jMlIC2+02oSZJ8v1w8Q10s7UH
	hxYdtcDrDMnx/BNKtm6AZL9xSpfwueYwfF2Nq8hHwghLxfIBOPJ2TLV5926ReObl+tzqWbmzRGf
	UtuAncH6q4Dx71XkMvZuE+22ZRbe8DhQlj3tytyVEFYicZlY4RK55/pvIlQFvXr0F2uX1ZNcyP2
	1T1tKqBrMbTZbO2N/oJO/iEqPL6lj46cG35Ww+w==
X-Google-Smtp-Source: AGHT+IHbDgBpEVih0OWeNYjBFHGh3HVRMCoCH7tpGwiuk6sZz3Nfar/dPjqC5tXVM9a9iz2RPe9XBQ==
X-Received: by 2002:a05:600c:19ce:b0:45d:84ca:8a7 with SMTP id 5b1f17b1804b1-45da74cf485mr25153155e9.14.1756977789645;
        Thu, 04 Sep 2025 02:23:09 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45c6faad9cfsm87635225e9.0.2025.09.04.02.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 02:23:09 -0700 (PDT)
Date: Thu, 4 Sep 2025 12:23:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: [bug report] wifi: ath11k: fix group data packet drops during rekey
Message-ID: <aLlaetkalDvWcB7b@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello Rameshkumar Sundaram,

Commit 97acb0259cc9 ("wifi: ath11k: fix group data packet drops
during rekey") from Aug 10, 2025 (linux-next), leads to the following
Smatch static checker warning:

	drivers/net/wireless/ath/ath11k/mac.c:4459 ath11k_mac_op_set_key()
	warn: bitwise AND condition is false here

drivers/net/wireless/ath/ath11k/mac.c
    4428 
    4429         /* Allow group key clearing only in AP mode when no stations are
    4430          * associated. There is a known race condition in firmware where
    4431          * group addressed packets may be dropped if the key is cleared
    4432          * and immediately set again during rekey.
    4433          *
    4434          * During GTK rekey, mac80211 issues a clear key (if the old key
    4435          * exists) followed by an install key operation for same key
    4436          * index. This causes ath11k to send two WMI commands in quick
    4437          * succession: one to clear the old key and another to install the
    4438          * new key in the same slot.
    4439          *
    4440          * Under certain conditions—especially under high load or time
    4441          * sensitive scenarios, firmware may process these commands
    4442          * asynchronously in a way that firmware assumes the key is
    4443          * cleared whereas hardware has a valid key. This inconsistency
    4444          * between hardware and firmware leads to group addressed packet
    4445          * drops after rekey.
    4446          * Only setting the same key again can restore a valid key in
    4447          * firmware and allow packets to be transmitted.
    4448          *
    4449          * There is a use case where an AP can transition from Secure mode
    4450          * to open mode without a vdev restart by just deleting all
    4451          * associated peers and clearing key, Hence allow clear key for
    4452          * that case alone. Mark arvif->reinstall_group_keys in such cases
    4453          * and reinstall the same key when the first peer is added,
    4454          * allowing firmware to recover from the race if it had occurred.
    4455          */
    4456 
    4457         is_ap_with_no_sta = (vif->type == NL80211_IFTYPE_AP &&
    4458                              !arvif->num_stations);
--> 4459         if ((flags & WMI_KEY_PAIRWISE) || cmd == SET_KEY || is_ap_with_no_sta) {
                              ^^^^^^^^^^^^^^^^
WMI_KEY_PAIRWISE is zero so this is false.

I should probably write a static checker warning for code that does:

	flags |= WMI_KEY_PAIRWISE;

    4460                 ret = ath11k_install_key(arvif, key, cmd, peer_addr, flags);
    4461                 if (ret) {
    4462                         ath11k_warn(ab, "ath11k_install_key failed (%d)\n", ret);

regards,
dan carpenter

