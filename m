Return-Path: <linux-wireless+bounces-11939-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B00E95E923
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 08:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBDE1B22908
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 06:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0A813A3F0;
	Mon, 26 Aug 2024 06:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="drDeuFGN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FEF139D07
	for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2024 06:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724654273; cv=none; b=mJveOf+jTemBC0rmv4wxTDIufWB/hSMPg6YdA9SM0Q9oJZM0b9yyxUjAh7NrVVNlYtcWWAd/dfGDULEUyNyzMmTC64hM041JhF9wY9K3wZcTK87YML9bytZz/1Qg/AIop6qK9iWI4oa8Jt6z+V4k+KFxmcyS5mIf7cUuYBlD2vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724654273; c=relaxed/simple;
	bh=tIqjP7wkBcetb1vT1IM+Khjh2UxNrkOVUPOtgZvtKvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r8Tu0dziAHm1DXGZBpIhb1VLOXOaZvC0vlhKEt4w8JnFJov1tVvrxsRqGXlnw1L8/pVuLUKZvkkLoyu0cFVYVz1jYzw196vZVn9BP/SwQ6Sk0FAGfPbHHV3ZXWJx8/N7ZJURJiP35ZLJraA3hG1eA+KomqenOaWHQCEiLTVWDv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=drDeuFGN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724654270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=45FOD6KTcPecHM5IOLAynL+DDZ1FnLvddcnxAZcFSfY=;
	b=drDeuFGN4Sc35CDeUZ8gpsXlFBC+4ptp7jjzVbb+kV0HBXrrU4Y0ywgildqtIwyVMhFvuN
	ejk9usHxKtLL/OGFDj2wyHVRdAiG5fFcAc4KNLWIFawMFWQVWqaQZOPSpXoTr6oFY7VV3b
	G5I8Te+D302YHrYmNPlVIl4awVg7yyI=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-2T1PKK2LPlO8JW72zkDbZg-1; Mon, 26 Aug 2024 02:37:48 -0400
X-MC-Unique: 2T1PKK2LPlO8JW72zkDbZg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-53437950a52so3021769e87.2
        for <linux-wireless@vger.kernel.org>; Sun, 25 Aug 2024 23:37:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724654267; x=1725259067;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=45FOD6KTcPecHM5IOLAynL+DDZ1FnLvddcnxAZcFSfY=;
        b=jVfei0wbJEymAQFXKQFlgCauQGfnqe6ws9ECPY8FJxmj25svBgV3o+krztMVC+ikLP
         grybhAGk8PBa4TRycVVWqyRzugrpJXZ1GF+weBcDpSLPCn5/g2gWsiFuz+GKGuoU5xTx
         gqWHbav7Iyv2uWqpODpR2TPVcXpVWZ4jKdrhPlyRofHQYe46f5mUjmQ5rhFT3OV9ww9J
         jBlRCwFeAbTET4SEHMEcub19cBeEgg9pxblAwaCsYF+rYS8mxHNyIlBqIs+C6D1Ht6ox
         2fQMXGzOUL590wuJocAgTMzOZOEdV59FJFlbUUJnI+G5f0fzCRRIyfKgkwPSCV1/RLiB
         G1TA==
X-Forwarded-Encrypted: i=1; AJvYcCXJamzHsiK0/vERqkiX6KdxkLIHH0HYh6BJQxE4Cojy1m4FB5Ctk+RODZDrrt1ymajbaP+GnO1Un9N116DIsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVhh2NPPPXiDgqnJkAoG6h2q7H+dgeIjUmK16GRGTLGmhGfT3Z
	GvthBV1as65HXK8RZBP0T9YyCdr7MAm6icu+IESCPmxnfuY6onCXhZYN+N+4uO72Ylmggu2uRTD
	VXPob9XEa5fK2vP5wRDa6/3e1kcN7FXSPKY1ghfDuMA7upgOWCaRQQwKDmLMWpMpn
X-Received: by 2002:a05:6512:3191:b0:52c:df3d:4e9d with SMTP id 2adb3069b0e04-534387bc61dmr5752297e87.37.1724654266739;
        Sun, 25 Aug 2024 23:37:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHybNBZvXvGT1JAjBIuJZk4lctTsFDvHNw8UbEsu8wiVnEjhBh18CnKX34zVm4ZL+xWbkh2ig==
X-Received: by 2002:a05:6512:3191:b0:52c:df3d:4e9d with SMTP id 2adb3069b0e04-534387bc61dmr5752279e87.37.1724654266155;
        Sun, 25 Aug 2024 23:37:46 -0700 (PDT)
Received: from [172.16.2.75] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f436badsm622206966b.139.2024.08.25.23.37.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Aug 2024 23:37:45 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, allison.henderson@oracle.com,
 dsahern@kernel.org, pshelar@ovn.org, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, rds-devel@oss.oracle.com, dccp@vger.kernel.org,
 dev@openvswitch.org, linux-afs@lists.infradead.org
Subject: Re: [PATCH net-next 6/8] net/openvswitch: Use max() to simplify the
 code
Date: Mon, 26 Aug 2024 08:37:44 +0200
X-Mailer: MailMate (1.14r6056)
Message-ID: <B4FCA95A-F6E0-4610-8671-780A2015C5F4@redhat.com>
In-Reply-To: <20240824074033.2134514-7-lihongbo22@huawei.com>
References: <20240824074033.2134514-1-lihongbo22@huawei.com>
 <20240824074033.2134514-7-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain



On 24 Aug 2024, at 9:40, Hongbo Li wrote:

> Let's use max() to simplify the code and fix the
> Coccinelle/coccicheck warning reported by minmax.cocci.
>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

The change looks good to me.

Acked-by: Eelco Chaudron <echaudro@redhat.com>
> ---
>  net/openvswitch/vport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/openvswitch/vport.c b/net/openvswitch/vport.c
> index 8732f6e51ae5..859208df65ea 100644
> --- a/net/openvswitch/vport.c
> +++ b/net/openvswitch/vport.c
> @@ -534,7 +534,7 @@ static int packet_length(const struct sk_buff *skb,
>  	 * account for 802.1ad. e.g. is_skb_forwardable().
>  	 */
>
> -	return length > 0 ? length : 0;
> +	return max(length, 0);
>  }
>
>  void ovs_vport_send(struct vport *vport, struct sk_buff *skb, u8 mac_proto)
> -- 
> 2.34.1


