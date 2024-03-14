Return-Path: <linux-wireless+bounces-4779-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B15A487C517
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 23:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C621C20F3D
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 22:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4980576037;
	Thu, 14 Mar 2024 22:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MI0k1QEt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29A77353C
	for <linux-wireless@vger.kernel.org>; Thu, 14 Mar 2024 22:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710454877; cv=none; b=QQ37tVV2nBuL/A02qS3IiW73x05SgHIwMW7Z3XkCaFJ1CZnH5BZEuAMeVrosj/YcS9qufztfXqJnK+jtK27JI6J/eGL7Iao1V3z/5xL7DybW1Y4d9ur2qvVTrzKptkZqM4SvtPl1KG9PxZs1b1U+hLzGjbPB78MXr4Joalmx6kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710454877; c=relaxed/simple;
	bh=qLIpJ6b4uEI+I8XiUwBoEY7BETtQk9LliHRabxWcX5w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=K728lbMje0kmATof3YSooRGVOvLVYgJiSNsMnjyw82LTquxs1w+8ywCEhBuTBjSfiBLA9HvcGrgtdkGSywqbQjYTEe04kOGXqlfCj7a1rejsxfsjN4h1Q6Q5n5KE4kAjLbSCOQz9j6vtEddrQE6eLPhmiF5MqdliuB2EjCRa4+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MI0k1QEt; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-430a65e973bso4896271cf.3
        for <linux-wireless@vger.kernel.org>; Thu, 14 Mar 2024 15:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710454874; x=1711059674; darn=vger.kernel.org;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMxQQRgsDua6Wk98zE294zaAZrPak0YF3cjHD4ME1DM=;
        b=MI0k1QEtGQqRC3c2pK02irmf63FZL6Mx5vuyFpoaE6SzEl+wPiXJmv5BhyD/xYbGEX
         N+SBAn154GHoSrOrlOgJAJCpOw1NtvwNSKnXJJ+okwRjKZSAPIjmvT/+2k/4XbSUnni4
         ZGpd9ia1XGPVbARXvZEgenspnCrmYSJmUueU0ZN/fSzCEJOH3wN4ghvlqm0F4XQRzVMW
         hYSScwioxUJvFMi/PRG75sHvMDdFoINKMseo2A+HL3w+n3xgMl09ZQtQ17QMOuaeScf6
         AOnr7S6IXr3DbRIyaPdjLq+MM8tL64bbLNXOWLDb4TED9e519GIGe7vME5JDBH9xe2Zl
         5IkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710454874; x=1711059674;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZMxQQRgsDua6Wk98zE294zaAZrPak0YF3cjHD4ME1DM=;
        b=OdTFcsL+rKW5APw2yNRNTRwsdB3YdABDP1p7sEOyhifuKidUMUletaV60lAmgn6bDO
         MjRh/nSrpjRMMwnz51LpUULoeZFHT6BinhHRx8U/FLJzBMt9xQLBPdt4TZLYV2sFI2EV
         YqcBOVF99TaXoPvy85VhQIxqyu6LZkTZUk2mJclP2A8g+kiz1/TalwiN11AN/4gNPdoM
         3LHcpzRhVrgVOpWuvCoJXWqrLeyHZYw1Sn4nUx52kctkbBowgFO9N+9ax7+vqw8e5Q41
         VtRgkjU9ipGb/x61QvJ/9FmC82fdb2BciVCW2EGAH3Hzj/rBOAMrPzltBrw5TnLh+kX/
         +Eyw==
X-Gm-Message-State: AOJu0Yzm7+g4zFE6WdHt8gwG9uv1i0ctw3scSMFUnQFeEM5Q5a/gvLet
	IcUnpQQ677VmqcGRoHc6ckQbK6i+kWtP7o9JWX/aySiTvXgrXgdWP87rwPo=
X-Google-Smtp-Source: AGHT+IGyJPQZrz3m+dDir4WVOwaguX5OMmk589OQonQlv0HCbh6QdAgGrHuR4hw9/AsD192dPBLiiw==
X-Received: by 2002:a05:622a:1111:b0:42f:1d90:472 with SMTP id e17-20020a05622a111100b0042f1d900472mr3232936qty.19.1710454874396;
        Thu, 14 Mar 2024 15:21:14 -0700 (PDT)
Received: from cy-server ([2620:0:e00:550a:9f1b:4292:76f0:cb8c])
        by smtp.gmail.com with ESMTPSA id d6-20020ac85ac6000000b0042f4041c24fsm1258565qtd.12.2024.03.14.15.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 15:21:14 -0700 (PDT)
Date: Thu, 14 Mar 2024 17:21:12 -0500
From: Chenyuan Yang <chenyuan0y@gmail.com>
To: briannorris@chromium.org, kvalo@kernel.org, johannes.berg@intel.com,
	horms@kernel.org, trix@redhat.com
Cc: linux-wireless@vger.kernel.org, zzjas98@gmail.com
Subject: [drivers/net/wireless/marvell] Question about a possible underflow
 in mwifiex_11h_handle_chanrpt_ready()
Message-ID: <ZfN4WHuqOIrO4Ef2@cy-server>
Reply-To: chenyuan0y@gmail.com
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Dear MARVELL Developers,

We are curious whether the function `mwifiex_11h_handle_chanrpt_ready()` might have an underflow.

The function is https://elixir.bootlin.com/linux/v6.8/source/drivers/net/wireless/marvell/mwifiex/11h.c#L193
and the relevant code is
```
int mwifiex_11h_handle_chanrpt_ready(struct mwifiex_private *priv,
				     struct sk_buff *skb)
{
	struct host_cmd_ds_chan_rpt_event *rpt_event;
	struct mwifiex_ie_types_chan_rpt_data *rpt;
	u16 event_len, tlv_len;

	rpt_event = (void *)(skb->data + sizeof(u32));
	event_len = skb->len - (sizeof(struct host_cmd_ds_chan_rpt_event)+
				sizeof(u32));
  ...
	while (event_len >= sizeof(struct mwifiex_ie_types_header)) {
		rpt = (void *)&rpt_event->tlvbuf;
		tlv_len = le16_to_cpu(rpt->header.len);

		switch (le16_to_cpu(rpt->header.type)) {
		case TLV_TYPE_CHANRPT_11H_BASIC:
			if (rpt->map.radar) {
				mwifiex_dbg(priv->adapter, MSG,
					    "RADAR Detected on channel %d!\n",
					    priv->dfs_chandef.chan->hw_value);
				cancel_delayed_work_sync(&priv->dfs_cac_work);
				cfg80211_cac_event(priv->netdev,
						   &priv->dfs_chandef,
						   NL80211_RADAR_DETECTED,
						   GFP_KERNEL);
			}
			break;
		default:
			break;
		}

		event_len -= (tlv_len + sizeof(rpt->header));
	}

	return 0;
}
```

Here if the `tlv_len + sizeof(rpt->header)` is greater than `event_len`, then `event_len` will underflow since they are both unsigned integers.
We are curious whether `event_len` is guaranteed to be greater than or equal to `tlv_len + sizeof(rpt->header)` in each iteration since we found that `sizeof(struct mwifiex_ie_types_header) == sizeof(rpt->header)`.

Please kindly correct us if we missed any key information. Looking forward to your response!

Best,
Chenyuan

