Return-Path: <linux-wireless+bounces-11998-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0E595F8B1
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 19:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34C7F1F23BB9
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 17:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2033218D629;
	Mon, 26 Aug 2024 17:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E2Rf8Mru"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45EE137903
	for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2024 17:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724695114; cv=none; b=fwY7hP75GEDIJRfPG+Fc262EhwcjeAbAGIrG/vCgQudybza2a173GqsDaIYy/fIXdXAFEM0WLuJEIl4iYhjlbJbMOLOlbMuYUKhYC2Y69o+DLO22BXE+8XoibKNsW+LrEBBwUYsSVMPyNSJ45G2NuhEGAzOH0yvMjDEmxuQSeUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724695114; c=relaxed/simple;
	bh=m1vUJTxnbLYPFWSRrsUTILzyGkkzYoBIFbULE6uwxGg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pMG7yQgHdLVAxoltCTjuqhbyCrkk/bF71G8bm8lDx4erktagxT8CyWa6MLPnR2r1jnzMHWGG6I3nn1b16HqfwZ8e49s0pPmaZ73lDcwGouS+vZ8Y05zZpC4CyL3kfA+yDWLv6WOR1p2g5EZxQyS3OBc+NZ7DyWKkph/M7J86vfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E2Rf8Mru; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724695110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PBgRdIE0fHsznPVlKpBGuT212MrBY8tRlvifAXJEjaA=;
	b=E2Rf8Mrut4jO5G5h9kacodR0dEmPYxWsPmwJ/6h/eUjuvQnPlBnOtpid/mqcdctIV75Qyw
	PKNbWh3P9eiryTv1W3ZIvgKV3bxOvcnnj+X+0LP9vwHuixmXkVAm+67L8pXyhv3vbjhPQl
	MmUp8ktZhF/xECil009eJHCL91hDV9I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-yQ2ZEuefOtCKeeNswtEoWw-1; Mon,
 26 Aug 2024 13:58:29 -0400
X-MC-Unique: yQ2ZEuefOtCKeeNswtEoWw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B8A91953956;
	Mon, 26 Aug 2024 17:58:26 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.8.86])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C1181955F40;
	Mon, 26 Aug 2024 17:58:21 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Hongbo Li via dev <ovs-dev@openvswitch.org>
Cc: <johannes@sipsolutions.net>,  <davem@davemloft.net>,
  <edumazet@google.com>,  <kuba@kernel.org>,  <pabeni@redhat.com>,
  <allison.henderson@oracle.com>,  <dsahern@kernel.org>,
  <pshelar@ovn.org>,  Hongbo Li <lihongbo22@huawei.com>,
  <linux-wireless@vger.kernel.org>,  <netdev@vger.kernel.org>,
  <rds-devel@oss.oracle.com>,  <dccp@vger.kernel.org>,
  <dev@openvswitch.org>,  <linux-afs@lists.infradead.org>
Subject: Re: [ovs-dev] [PATCH net-next 6/8] net/openvswitch: Use max() to
 simplify the code
In-Reply-To: <20240824074033.2134514-7-lihongbo22@huawei.com> (Hongbo Li via
	dev's message of "Sat, 24 Aug 2024 15:40:31 +0800")
References: <20240824074033.2134514-1-lihongbo22@huawei.com>
	<20240824074033.2134514-7-lihongbo22@huawei.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Mon, 26 Aug 2024 13:58:19 -0400
Message-ID: <f7t4j7788uc.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hongbo Li via dev <ovs-dev@openvswitch.org> writes:

> Let's use max() to simplify the code and fix the
> Coccinelle/coccicheck warning reported by minmax.cocci.
>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---

Reviewed-by: Aaron Conole <aconole@redhat.com>

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


