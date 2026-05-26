Return-Path: <linux-wireless+bounces-36899-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILSsH2uFFWpYWQcAu9opvQ
	(envelope-from <linux-wireless+bounces-36899-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 13:35:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EA95D4EEB
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 13:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E9A13300BC8B
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 11:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE073DFC84;
	Tue, 26 May 2026 11:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X+VOOCHB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hfiE5spx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892093E0C5F
	for <linux-wireless@vger.kernel.org>; Tue, 26 May 2026 11:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779795298; cv=none; b=ujGlTGue8gaXKkm3otY1lrkDovQf3K/GbycDH6/dbdZ6o91hR/so3pAhAiVXmoXxmSfmErZ1dzKL2vnM0GBblV44I3zO+R8BvB0o93X7t4xDkLnzRqFBlkbCUGJLvdGpWHh6qoDp9Ua6KRppI19ebTHS9KLrkrNcVVpR+apC/LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779795298; c=relaxed/simple;
	bh=ocxFYI38hxzb1ERZvNMOfcjBpfFa+PxSGRxdLDGrzLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UcLrZ18xuLZnxM7BRC919y3HCGvHp9wCDTmg7JMysask2icTaOLmeC1F+/G0ureqWe6sYgxktjxAjuDQLmUTO7aqBHcGKoNWBu5VtCaVrIjVKZXiaodYO7FOOxaJQ17tf5ZSo3hJcopiqY62H+ipqJPaObHEubDFo9gi63bmamc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X+VOOCHB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hfiE5spx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779795294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VD+dmiG81dGo1mjueRmNr772xEYjIurIakGJoB8fU4s=;
	b=X+VOOCHBPLPKsjaKrZYCJrqdeKMKq/0CExH2fF3OgoW+y0CoHU5AJ0Cgg4XfFyH0wTwUri
	2RhTtJDZjvZmOUugidupieE5lYgFf20Uru+vUxaRWS7HvxGlXIlvO1ZOj+UU2zuEByPmcc
	W2dcBKsQCPSC0BZSlmIYugi2BEcz/0I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-wACvfQHGN0aa06XXsmOX9g-1; Tue, 26 May 2026 07:34:50 -0400
X-MC-Unique: wACvfQHGN0aa06XXsmOX9g-1
X-Mimecast-MFC-AGG-ID: wACvfQHGN0aa06XXsmOX9g_1779795290
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490479c2911so44522925e9.2
        for <linux-wireless@vger.kernel.org>; Tue, 26 May 2026 04:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779795289; x=1780400089; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VD+dmiG81dGo1mjueRmNr772xEYjIurIakGJoB8fU4s=;
        b=hfiE5spxqeYdkg5VjqiRzAdEOmaal3cMZxcwaGdFLiJO9LZ0tFWSvuwEKG8fAi/Acd
         uLLF29L6irGvrhUSPvpbWfM2v1t2moxU4DkA07TAiZqh1DTa0Ud4VuDlY1bEoc4rVBry
         5mWqajx+YLcORBTxxnddteBCwgKwE1X+K6YahYn2Q5i0cPckb2ZuuatUfvEMVp7he3SD
         mbows/h2tdQiQ2jEqq1GJN85C73/Wip+qWWfrd81eOZJMyex3ZApisyzqzXuKT5aFk/3
         btEhOC9RF2sEQPcI5s2JOduYxlOeC5TMZyyEW/L0mdVs13mIahZb0tUqjkE4nQFvopx+
         5bNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779795289; x=1780400089;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VD+dmiG81dGo1mjueRmNr772xEYjIurIakGJoB8fU4s=;
        b=I3X79ydemztiMKr3+pJdldZXhPh1JMCKAGY1J7tB4nlpjRrkFCARkEg8RRESHL1hay
         CGKL2e+r83jytE/YPGU6s1QAqkeYI3DsMUKp3tgGqIenx7ePn/P2sVrV/VOy0A6hQjK6
         9VVMO+79DJkf7LRxUqbemS66MWUhXj4Oz4xmme9tJTd26TWK9EAluyib0dC+9G7ukfYy
         cwcJqB/gg4+vhEnD8yO2MuvSYmqkqxDryFdb9yZut0q6oUi0Z6gR9MTwwW5NWmis87u6
         tPUaNW339chKeslQy+f3+7gv3iKHOOvZlcUgtY8xt1Qm0QjNCgXctT+a9AVWEtu+w6+R
         U8DA==
X-Forwarded-Encrypted: i=1; AFNElJ9zlRxmKnnwaJHotMQZnC5oN2Wh6vEtFWxcH+JCwFkOeSAGxB4piPKdts2PX6txjQbH360ZmPIvTgvdcO93HA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8ji8V4m7KOGohvuvBerUfMADjUEHlLmB6xwys9GrR99bGJt4H
	QSVrOccKuZSydIb54tyNHuZCIV8dvW/WBvJd78UXDAT84EXXKZlFjjdsX3qTO6JZzZ33ZijwM2J
	otpXn5+vVA0HWbH+PnXv1s02Wd9MzD5oIjqmF0NVN/vY5M69bAVx1BvL3Iu8vAyE07Gx2
X-Gm-Gg: Acq92OE/z4FOzq23n2pMpkCTAJJ/VXH4R2QCFVTEa7cw/y40XhKkXWWNdBEV1Euf9Qk
	8oTwIJQESyz+rDQGSoNJAcYTSGrXFR4VdYr8fQ/lHCTOx13xtUC2TXVAHaaaI1e3HWTCSrHXiPn
	hvw0QU2QfwoWsuyilgMCpJopqMKETC6rnOAQpp7Fp/DEZcfQlJ5YCkqp7k+K/CbfP3zEASILp3Y
	c6TmV42i0kVf4Kn+pzL4U1mySJMvgqncsoARqIqWQvRsZsbhBFFxl8rLlYFgilw3vzd0nLembtI
	EGicYblbhXaAMcw2iKfl9hI2p6QQRN8I3+xnRqHY7LnLPMe7Ro/oxx9HzD4U2KubkFQ+tymYsDu
	1o0yiXWNfabie6qRnQTlGq5ozCG6dT/jaWDTIcaAZ031ky4BRZ2wWiiwSgQ==
X-Received: by 2002:a05:600c:4ecc:b0:48a:56de:d62a with SMTP id 5b1f17b1804b1-490424b3c7fmr275107495e9.11.1779795289588;
        Tue, 26 May 2026 04:34:49 -0700 (PDT)
X-Received: by 2002:a05:600c:4ecc:b0:48a:56de:d62a with SMTP id 5b1f17b1804b1-490424b3c7fmr275106815e9.11.1779795289064;
        Tue, 26 May 2026 04:34:49 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.152])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904526c926sm565711385e9.1.2026.05.26.04.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 04:34:48 -0700 (PDT)
Message-ID: <5a54d307-0b8c-468d-9183-6433f9daba56@redhat.com>
Date: Tue, 26 May 2026 13:34:46 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] net: mhi_net: Hold runtime PM during active data
 path operations
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>, mhi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-wireless@vger.kernel.org,
 ath11k@lists.infradead.org, ath12k@lists.infradead.org,
 netdev@vger.kernel.org, mayank.rana@oss.qualcomm.com,
 quic_vbadigan@quicinc.com, vivek.pernamitta@oss.qualcomm.com
References: <20260522-mhi_runtimepm-v2-0-fbebf41a82bb@oss.qualcomm.com>
 <20260522-mhi_runtimepm-v2-3-fbebf41a82bb@oss.qualcomm.com>
 <CAFEp6-1sdQn11NKom6cfwtJvZX-CnPRpJeVzQ+99Sb4A4L-qaQ@mail.gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <CAFEp6-1sdQn11NKom6cfwtJvZX-CnPRpJeVzQ+99Sb4A4L-qaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,lunn.ch,davemloft.net,google.com,gmail.com,sipsolutions.net,lists.linux.dev,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,quicinc.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-36899-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 71EA95D4EEB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/22/26 10:09 PM, Loic Poulain wrote:
> On Fri, May 22, 2026 at 12:01 PM Krishna Chaitanya Chundru
> <krishna.chundru@oss.qualcomm.com> wrote:
>>
>> The mhi_net driver does not coordinate with runtime PM, which allows the
>> underlying MHI controller to be runtime-suspended while transmit, receive,
>> or RX buffer refill operations are in progress. This can lead to stalled
>> transfers or failed queueing once runtime PM is enabled in the MHI core.
>>
>> Add runtime PM reference counting to the mhi_net data path to keep the
>> controller active for the duration of TX, RX, and buffer management
>> operations. Enable runtime PM during probe and take/release references
>> explicitly around these critical paths.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>  drivers/net/mhi_net.c | 39 +++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>>
>> diff --git a/drivers/net/mhi_net.c b/drivers/net/mhi_net.c
>> index ae169929a9d8..5d7f9ccdb17b 100644
>> --- a/drivers/net/mhi_net.c
>> +++ b/drivers/net/mhi_net.c
>> @@ -9,6 +9,7 @@
>>  #include <linux/mod_devicetable.h>
>>  #include <linux/module.h>
>>  #include <linux/netdevice.h>
>> +#include <linux/pm_runtime.h>
>>  #include <linux/skbuff.h>
>>  #include <linux/u64_stats_sync.h>
>>
>> @@ -76,11 +77,19 @@ static netdev_tx_t mhi_ndo_xmit(struct sk_buff *skb, struct net_device *ndev)
>>         struct mhi_device *mdev = mhi_netdev->mdev;
>>         int err;
>>
>> +       err = pm_runtime_get(&mdev->dev);
>> +       if (err < 0 && err != -EINPROGRESS) {
>> +               dev_err(&mdev->dev, "pm_runtime_get failed %d\n", err);
>> +               pm_runtime_put_noidle(&mdev->dev);
>> +               goto exit_drop;
>> +       }
>> +
> 
> I am wondering what the value is in pushing this PM responsibility to
> each individual MHI client driver and requiring every MHI operation to
> be bracketed with runtime PM handling.
> 
> What does the client driver know here that the MHI core itself cannot
> handle centrally? It feels like ensuring the controller is
> runtime-active during transfer could be handled generically in the
> framework instead of duplicating the same logic in every client.

Indeed if *feel* like the MHI core should be able to put together all
the status needed to correctly track the PM.

Adding PM tracking to the NIC driver network data-path looks quite bad.

/P


