Return-Path: <linux-wireless+bounces-35943-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGgjDGcm+mlIKQMAu9opvQ
	(envelope-from <linux-wireless+bounces-35943-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 19:18:31 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 819C94D1EEB
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 19:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18CE43068E5B
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 17:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CD43AD529;
	Tue,  5 May 2026 17:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGy3X/s2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E19264614
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 17:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778000776; cv=none; b=pwOxP1Kd31UAB7m110Pqh5PCXdzZttbnO2IN4+dKYPWOqJvrWirWU9lJvCsxt4VM7TQwa/OigjqARMj3MtgRnl+OY985Lb6i6k0BRu3NmNayMjFrb2O4IMMeHpz8W3aaRtTIY8RphLLjJY0SIfqj7IBL1Rt0bFAm1Q6zah/wBts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778000776; c=relaxed/simple;
	bh=/oQgEkgaWo+w1lDwdWXolBH1IWJXrazDobI16g/cufQ=;
	h=Message-ID:Date:From:To:Subject; b=ausFQI3A2EqQ6GJtyEa+1fpLjnGHbkQKNgBIFeUVkQaDl3st1UmJzsd3i+ZqeQbRqQzNeuLFptyG+RsNG9Q2kK9pp9s/xDV7BQnHlM0DQwEk8EMb0lOlmlJIggMBgUtvO+7H7jlSanKfLXyv9+fq24g81TVTKY5EKyvS3iI/eCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGy3X/s2; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51306c36c3eso9373631cf.0
        for <linux-wireless@vger.kernel.org>; Tue, 05 May 2026 10:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778000774; x=1778605574; darn=vger.kernel.org;
        h=subject:to:from:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/oQgEkgaWo+w1lDwdWXolBH1IWJXrazDobI16g/cufQ=;
        b=YGy3X/s2UF1excxbYp8jzH8s0f4y47OZOECumeif4fx3yGpW8vI1KxBhmaxkB44LlY
         wa5kZPKglULnogP04OW0aMHxJDH620Ym+C+oRwUd0PV0IyH6SazNB9cdURcW0W+v5fr0
         2ylF+ONKiR/lv+STycC0N7uAP3kPhT1TY4osxUsICq7VaG9vgZse0XetMKEKZO8DHRfC
         c8hvfrwdZtU9VG1lJFBZ1z5X2Kg9TeXSY9/4aulKNOvomEBzDglPnXQslOdfRwCZLI2x
         Fjj+e95UlpJVn+Xl2ipLyNlwynMfvvGupar+pThsPgxmCD695t6kWMbEmzzgU1NDONEM
         l3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778000774; x=1778605574;
        h=subject:to:from:date:message-id:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/oQgEkgaWo+w1lDwdWXolBH1IWJXrazDobI16g/cufQ=;
        b=oTXYFjvQcWaL8keo+Vr4E3KwGtX5asR82x4YfG53YlFqVoL0TytSDNa8jT/+A6DZ9L
         Bsvo2enjSlRahXDo4iNk0sO5UYldUfHb+R77vMz5piZNwfViLf1+raejByrpIKZxpYyT
         poPueCfQn01oAScP40dD2jLqlNROttYICueG7Yq20QddBI1kk49SBQyyIO3kZITC+rxA
         P+jg3PDKsbUsZK3AArrXF7s9HPTTkTI1t6La2AUyrQdzgBCAlnEDLd6nEMqHMfJS4ili
         hiRMhZOv4+PM32DQHMAFTRTmurjBkjlSKyq76ywGWQeWDV/MN1MXR9uJ7Sevy8Utaspw
         RScg==
X-Gm-Message-State: AOJu0YzylIIq5OL0Na2wTLq/vGDN2i39OcbP2VE2Amn2R9WbjGRSWC1r
	3H7h9D4rGjZ3nhvBk8llVw54zv1aRW4VqFeB5uAEyaF/exArvP4ZhW1Y2Rt9Abyf
X-Gm-Gg: AeBDies1syok8elSy6SQlIPVE0Qv4MFTLfj/CNIu0h/h7BFkyfXCsul9JJfWfQCftzY
	doKYu/d/y2EfMlC1WVJi6xrxaV4VRg7LwQ4wC002jA8uZ2QmoMORxqUJbN63YBNQS1ojsE6I0iQ
	YSLTNmlbJmf71KqRXGYOCDmZzg5qhZigEhKz6w8gI/pwcfFAKD9OiFrxzcmcLi7aeATnixvW6wR
	6mf/MKrP9Wye83XpIYw93Tg1OfN069vyxWuxZhDXq5k7U6riT++0fLiZ2cy09O6sHffvjDilwOJ
	5m6LL2iGNLn7ssKr2Pd2jvpOCvVunvI9IFyViAIPvgjG5yQZevHEfB7XndIZ97NjPWTwGA/AgIX
	FkanVax0+EUE/4roubNjGyAp6Yvwj9WlfppZPBxXiseonhW9gRDCw6dFCIGo9ma6m22AZo+cWM9
	H2X7GrCw+N5ZDpZWyWg+165Zm8gl5uHQLcOMJnEEKQGRuJsZ2CWzalbFwOQJOmuBrpE4XYkxCzU
	fFMkRgUeqLYFuH8SYwMZPfhaAbmN0dTlwZi6xeNQB2IiWvOSU700g==
X-Received: by 2002:ac8:5990:0:b0:50d:d1ea:65dd with SMTP id d75a77b69052e-513069be702mr58386271cf.14.1778000773835;
        Tue, 05 May 2026 10:06:13 -0700 (PDT)
Received: from localhost (ec2-18-190-238-202.us-east-2.compute.amazonaws.com. [18.190.238.202])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-510408ddcdesm147025401cf.4.2026.05.05.10.06.12
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 10:06:12 -0700 (PDT)
Message-ID: <69fa2384.c80a0220.e9f65.8d9a@mx.google.com>
Date: Tue, 05 May 2026 10:06:12 -0700 (PDT)
From: ferdinandleka859@gmail.com
X-Google-Original-From: GeekSquad
To: linux-wireless@vger.kernel.org
Subject: Hey, TQMPXKWZ91 39064302677 is your order number
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 819C94D1EEB
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [7.14 / 15.00];
	R_BAD_CTE_7BIT(3.50)[unknown];
	BROKEN_CONTENT_TYPE(1.50)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	R_DKIM_REJECT(1.00)[gmail.com:s=20251104];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	TAGGED_FROM(0.00)[bounces-35943-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	GREYLIST(0.00)[pass,body];
	NEURAL_SPAM(0.00)[0.046];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ferdinandleka859@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:-];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mx.google.com:mid]
X-Spam: Yes

Dear admin,

We hope this message finds you well. We’re reaching out to inform you that your subscription with GeekSquad is set to renew automatically very soon. As part of this process, a payment of 379.5 will be processed using the payment method currently associated with your account. This automatic renewal ensures that your access to GeekSquad services remains uninterrupted and that you continue to enjoy the full range of benefits and features that come with your membership. For your reference, your Subscription ID is 7079-SM-9415, and your Member ID is 97909-9161. If you have any questions, need to make updates to your account, or are considering cancelling your subscription, we kindly ask that you contact our support team before the renewal date to ensure we can assist you in time. Our customer support team is available and ready to help at (808)-210-4827, and they will be happy to guide you through any changes you may need to make. Please note that this is an automated notification, and 
 replies to this email are not monitored. Also, as a reminder, GeekSquad will never ask for your personal or sensitive information via email, so please be cautious with your information online. We thank you sincerely for being a part of the GeekSquad community and for your continued trust in our services. Your ongoing support means a great deal to us, and we’re committed to continuing to serve you with excellence.

Best regards,
The GeekSquad Team
337 Calhoun Ave Calumet City Il 60409 United States
📞 (808)-210-4827

