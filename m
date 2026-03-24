Return-Path: <linux-wireless+bounces-33743-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBHxK+vZwWmJXQQAu9opvQ
	(envelope-from <linux-wireless+bounces-33743-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 01:25:15 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2B22FFA49
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 01:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 208BA3061752
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 00:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F47578F26;
	Tue, 24 Mar 2026 00:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="smJxckB7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C1E1A3164
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 00:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774311469; cv=pass; b=YgeBtT3I62vW+iC6SOSgxlDIpkygDSWh75zpH8q0S2yqWLMqoXn6Fo6MAVns+teAzeauztjPo88dSbRjbyCD6/W4xX4qhr/yYoLeSwxy6/TWF8SkPbqC6BbZGrsQ43foiC18ptfavmmzRkVgjyt+DPx92mBDpUvFnGJkck+4sag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774311469; c=relaxed/simple;
	bh=9oCgadqEVU2zvb0k0XRfu/eES10DXnQlTYIGPtr8RWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XPevp3GmrGVCwBfpuxbzMH3ITNYRl+mdUuYlwveTPdp4tcsGRHqSgo4JXxoQE7tjFh8mHY8liB8As3xOvyc2c6qn4pv0PTNhYILKLK6MvjR+F+WkklLrFIdpi26lnuQqbmE8799l01Rcx/tyuCKQHw9iBzwsadz2cEAcefDFYUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=smJxckB7; arc=pass smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-404254ffe8aso3043943fac.0
        for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 17:17:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774311467; cv=none;
        d=google.com; s=arc-20240605;
        b=CbbRvxAYAuFQ+HH1tj4vQulFHPw3kmxwOfzL08amk+9MUiiASuDQWNz50+mfJpNO4N
         keztu5gcLEjjI2FcBRyFsTyMEr3qS8fV+FZvS7SzQajptxlCUUHqC6mhUsvLztRsL5ad
         pUwyUjpGf9MEewjqD3fVOSLhW6eVTBw26LfUThiVIzX48zoZp6xXR1xjNdgyhZRxzFVa
         RwWtpYdhz1txoLDIlBHmSTHB0oChT7Kqtj6Gu6QOcnRwy90EVjkpC6NOopL9OwMMDEBK
         FwSXcfiNNxb0tQJ8AItbgWI8LHfkWOiMc3RKrtFN6nDi2JUepmf54oXv6V9C75oFuc+4
         hdOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZtgfN82JuRRJLq+eK9RQAC5+e7XuzEZhzio9rgkzNNA=;
        fh=E0TB4y4LMaoFv6/Nw7x0a0BXVcSkrLpEywfy4qTdIUc=;
        b=YDQPOCjpGgCwO4FrJiu2wva99A74hKshakPu5pEmGUx7SmVIB/o8zxzpkcEYBEvcUA
         m4mOIxqDLP6sWjmT/u7yj+hihZaNbhzu420AmKWh+xjB4wQeOq5dulEb25GXQINv4wSy
         lUzEqGqMsI8PfWw6oLIEYtbs3f++xuOsQqEkY3MKPswsH71Afy/yN9Djz98ldSskX+r6
         yQ6GQh7Cm74zibGMce3p0P1ZxiaJcZa1Emn94zu1l5ltiCoo+JEBtoONTUknKpyeLwuG
         6X0Hn95HDlIE3rb6p5hHh4UkanhK8Ae/b0GmaIdO+j5itLN5nNMBE+rpSvYGD90DKfvY
         rzcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774311467; x=1774916267; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZtgfN82JuRRJLq+eK9RQAC5+e7XuzEZhzio9rgkzNNA=;
        b=smJxckB7IYhGOBZAuw8EGF9d2Lv+x2b19MSk3PSElmR70a2VB54OPty57bMqX4x3GQ
         juKnvODBnNAY8ZBdGsHZsby6TM40JHqnC770pdx0BacE2RgMvW1Dtkh95BASFp5F7D5A
         lolj/nmiPHi/6gcV7h3CeYzz1kqYa6vKqxl2zzPCLL5/BKQbHGOlUu8OFe2VlzYCP9Fy
         QQmK6EjAj0CQhkcrj1WOxtujlBrbPnNFROpn9iU6cs1JIgjzEU8gtMXDRTPV4CrIoN3N
         7nh/Im3dgiyZVBggKG7BK6YNeZ2deF+fj2v6rWJFh/QvS1TpQJ46AOW21cSgRoonM9P3
         ckHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774311467; x=1774916267;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZtgfN82JuRRJLq+eK9RQAC5+e7XuzEZhzio9rgkzNNA=;
        b=PsGSYom6qtHyB+yU6OXj9nRZn2p8jsQAzw75yj6ksvKEhRjOX641UsUsXWukY79vxg
         aSlxeffm1wPr9/J2hyCRbj0nRI5RbrPuMO8OX9IN1BNMAcBPXDQ5qwnoTkvL/ioCzAAX
         ckS8TkvlkrTzwHaJJugJE8jigW10OjlvJxQVf4daPS8vocgM7HUtF4hG1DSkooyTz2Zh
         xJikEC5ffeR58yIsCRpmL9x6fhYSM5ErXem1kqJdye70HN2ejeJFc2urdMdkXrZ6mDV3
         ZB3w40CNmlmIKjMHD0j1P5lLuM38QQ1suzVk8W6oVqqx3PiMSsvDjDtGW66dIfEN+phS
         bf7A==
X-Gm-Message-State: AOJu0Yz4fsAQNrOgoE6n421EUFzwxQVgTy7f9oiR2FwlBZGN6Yj3Vlnq
	o/avHQ1gVRB/YUMqunac0T2ugT9C1Ty8k2HjxNh7jtX+odkxQTvUYcpFbNhw+S34gvH9lgfFACE
	/IlFQS34KD590enFOJ+MP51mljDqROhk=
X-Gm-Gg: ATEYQzynvQMIU3xhrVRKE6yYK5tCqF0OErW9LkszLTyNMZZ5H9Ea9sXsXdFtKas5pzF
	bRx69nOj7+re3Ci2aizqniDE7F20jX2kDAPby769lW+ckOc1m9Rq2ohqcU6lyM7UqTdJxXit3W8
	WwZ7jTuarV8IW07qVX7xoBUwaD17nDxIG3HOp63UPHyAtrtWOPclHrClKZrEvh4etvmUMc3Zgxl
	emXCf6TtHABQHdTwdh3hDgehs/Y0qDlg80h3ea+jpRC+FuRb3fA+h8i+EdlQmkzF0m/wtkt745j
	aUBYWyWLL75WyuBooDs=
X-Received: by 2002:a05:6871:4714:b0:414:9285:c243 with SMTP id
 586e51a60fabf-41c877007d7mr1035050fac.21.1774311466662; Mon, 23 Mar 2026
 17:17:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323015849.9424-1-pkshih@realtek.com>
In-Reply-To: <20260323015849.9424-1-pkshih@realtek.com>
From: LB F <goainwo@gmail.com>
Date: Tue, 24 Mar 2026 02:17:10 +0200
X-Gm-Features: AQROBzB7yF6ghhkHNrdDxcZ_6FZZ-AGRb0OshWWZSmP1JnOm998MQZeLXK-whqc
Message-ID: <CALdGYqS_ROWrsYishahHxEthwYYfxurOxCCWJjOApgbnmekeWw@mail.gmail.com>
Subject: Re: [PATCH rtw-next] wifi: rtw88: validate RX rate to prevent out-of-bound
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33743-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[goainwo@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,realtek.com:email]
X-Rspamd-Queue-Id: 0B2B22FFA49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ping-Ke Shih <pkshih@realtek.com> wrote:
> The reported RX rate might be unexpected, causing kernel warns:
>   Rate marked as a VHT rate but data is invalid: MCS: 0, NSS: 0
>   WARNING: net/mac80211/rx.c:5491 at ieee80211_rx_list+0x183/0x1020 [mac80211]
> As the RX rate can be index of an array under certain conditions, validate
> it to prevent accessing array out-of-bound potentially.

Tested on HP Notebook P3S95EA#ACB (kernel 6.19.9-1-cachyos):

  - No WARNING: net/mac80211/rx.c:5491 observed after patch.
  - System remains fully stable through idle, load, Bluetooth A2DP
    usage, and multiple suspend/resume cycles.
  - Zero h2c or lps errors in dmesg.

Tested-by: Oleksandr Havrylov <goainwo@gmail.com>

