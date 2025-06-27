Return-Path: <linux-wireless+bounces-24620-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E02ECAEBC1A
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 17:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2569B3A53C9
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 15:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967F22EA478;
	Fri, 27 Jun 2025 15:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZJcFLMNQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC7A2E8DE4
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 15:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751038653; cv=none; b=EddhTlUjXtkmJxps7MGNXHKyh33l1nOw5KEZ8iP4SzyqZk8aYUp95WL+KGzMME0AocZFGo51XpNoH9ag2EB9M25E1wolH13Ige0CQDPrKtOTVBsdvs79BEQiApYmGh9ACuX9YC7R3OSN1pb4tTfXKhrOczhAIvmqrPUPaLqkJUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751038653; c=relaxed/simple;
	bh=h+WmilYbqOfR6LzuPdZvbGipIP5KNeKruXFDPtViNd4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=d6MAnr4DD0f9xLgcKX9d+znfUrbO6UVj6xChv5xbimIv2SWyaFwra0g9T/uWRxgjrkgOmw4f3bIUIwsucWYFmc6F3fBPacE96zkkoAYNA1nQqVXtITXTLioCN25f9Fl0c/Ki1Tt53RegO3sB9pw6oBIYc+gHjEguxB/oxq0PWeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZJcFLMNQ; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4080548891fso936235b6e.3
        for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 08:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751038651; x=1751643451; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=44pdT9X1rCTQyKK3l9Rt0jWxhLY8uyoVlC7v/EKTJfs=;
        b=ZJcFLMNQMSY8psRsvn+abYBQuPju05Fpna1BRbshYSkZSOBTpjvubOao3ACs+08JD2
         ke970v9cAB01JmX57Zc6mOu9wpdrWQsqUHc29v0omd/Sggy8AQiN8F+g/OdNtnj+Amb2
         G7K/U/J5lUWY2pHcZ3Nu81VQfVHehNUuyAV9a5gsSFi7CN0vRqDnfoDoTpQy3uWxPRr8
         zyAye3QOtbZUOh2yPi+8Yh9w1kYRgnwakkCoKF2jyN/TTHktbG1sKDF/an2fy7Ylh5gO
         bni6OrZY4EPSJaCxOe495DxcDFY/hCHo5qXCD4gqA5jLiQoR3jV7ZqsYJDuTYvNyQn5+
         aN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751038651; x=1751643451;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=44pdT9X1rCTQyKK3l9Rt0jWxhLY8uyoVlC7v/EKTJfs=;
        b=bg9Gtea1lR9OUb0lUjQGa/fQZR/ca1L3nTpHovdFyd5VLy0J+JNgE4MXhjOr+n8/Df
         IPyURuINwey/9u6qJnR8l7LxeSfYZ9zr2Vjd+YFBROkSKE/afeJtNTMXkC9yvaHMSbqM
         xoDCUHwaNy40+juD2cSaq11R5erISZWq4D3CACblUDaoNeVOrlf18ZYzc8+sSADrLMuJ
         +3sPJM7CjOxLMLA+Je6lkDDMjxDABbYagCRIeIsQf9dn8bD8tRMdNrr7Je/NUxMQGVz/
         VyOHMfKrjcNrbFuu6waWiauIksHYfU8OD6+GD+zsI0Fs/gTNYN5zW9mCQg+10DLF1dEc
         roLw==
X-Gm-Message-State: AOJu0YypHglfPOqDnsxKhb7bryPqhriksi0FCbVXqMVIUTg5Lakn4b/0
	u0N8rtt8YaF6dQya3anJCaNLgTgLJyPEypZ7s3DJkxR7yKXQfFooNCWpbcKx+6TVK7kzTyU2EGp
	l/JyjcGM=
X-Gm-Gg: ASbGncvBcIRM5I+qdZWtEl82+0ERAXYVyf0WIyhWbDcKcitN7eE5N/efN3KlYAk3BFr
	RSjf+UWBtDXXaqq29nZuGx0kVErJYLcijSgaAXhKTsuvUiF97kR3Nvaowmt1Q1tW5Yqcgoxkm1+
	8pAOurTC3uOPiy3RthyGynLJeBprkJkI50tneFb6cUz9z5OOjrOhgL/s8MH0qR1igotdPXhrhLa
	o8m32ppaWCY7ojl0n7UpwMuh7+xnrUQn7I004WRMhCiJePcsikfqxcU6GSe+fXIVEZGHMZRgmSW
	guKZcMuHtafmMrPViXtehP6Ux5/iOsrZ/+u1uWGNvHRQQ0sPqRm1xz1fBmv0T5P+M9ktdg==
X-Google-Smtp-Source: AGHT+IGsinXEYnqrDUB9W0quJ+4KEzS2zlK65CdTrAqqO9lP31atj+JD3pX4j3CG5XENJC12mFfcPA==
X-Received: by 2002:a05:6870:e985:b0:2d5:b2ae:2ebd with SMTP id 586e51a60fabf-2efed7767c5mr2442443fac.34.1751038650662;
        Fri, 27 Jun 2025 08:37:30 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:e9c1:9891:4bfd:dadf])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2efd4efb7cfsm909309fac.16.2025.06.27.08.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 08:37:29 -0700 (PDT)
Date: Fri, 27 Jun 2025 10:37:26 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Subject: [bug report] wifi: cfg80211: allocate memory for link_station info
 structure
Message-ID: <81f30515-a83d-4b05-a9d1-e349969df9e9@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Sarika Sharma,

Commit 49e47223ecc4 ("wifi: cfg80211: allocate memory for
link_station info structure") from May 28, 2025 (linux-next), leads
to the following Smatch static checker warning:

	net/wireless/nl80211.c:7505 nl80211_dump_station()
	warn: 'sinfo.pertid' double freed

net/wireless/nl80211.c
    7443 static int nl80211_dump_station(struct sk_buff *skb,
    7444                                 struct netlink_callback *cb)
    7445 {
    7446         struct station_info sinfo;
    7447         struct cfg80211_registered_device *rdev;
    7448         struct wireless_dev *wdev;
    7449         u8 mac_addr[ETH_ALEN];
    7450         int sta_idx = cb->args[2];
    7451         int err, i;
    7452 
    7453         err = nl80211_prepare_wdev_dump(cb, &rdev, &wdev, NULL);
    7454         if (err)
    7455                 return err;
    7456         /* nl80211_prepare_wdev_dump acquired it in the successful case */
    7457         __acquire(&rdev->wiphy.mtx);
    7458 
    7459         if (!wdev->netdev) {
    7460                 err = -EINVAL;
    7461                 goto out_err;
    7462         }
    7463 
    7464         if (!rdev->ops->dump_station) {
    7465                 err = -EOPNOTSUPP;
    7466                 goto out_err;
    7467         }
    7468 
    7469         while (1) {
    7470                 memset(&sinfo, 0, sizeof(sinfo));
    7471 
    7472                 for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
    7473                         sinfo.links[i] =
    7474                                 kzalloc(sizeof(*sinfo.links[0]), GFP_KERNEL);
    7475                         if (!sinfo.links[i]) {
    7476                                 err = -ENOMEM;
    7477                                 goto out_err;
    7478                         }
    7479                 }
    7480 
    7481                 err = rdev_dump_station(rdev, wdev->netdev, sta_idx,
    7482                                         mac_addr, &sinfo);
    7483                 if (err == -ENOENT)
    7484                         break;
    7485                 if (err)
    7486                         goto out_err;
    7487 
    7488                 if (sinfo.valid_links)
    7489                         cfg80211_sta_set_mld_sinfo(&sinfo);
    7490 
    7491                 if (nl80211_send_station(skb, NL80211_CMD_NEW_STATION,

The nl80211_send_station() function calls cfg80211_sinfo_release_content()
on error.

    7492                                 NETLINK_CB(cb->skb).portid,
    7493                                 cb->nlh->nlmsg_seq, NLM_F_MULTI,
    7494                                 rdev, wdev->netdev, mac_addr,
    7495                                 &sinfo) < 0)
    7496                         goto out;
    7497 
    7498                 sta_idx++;
    7499         }
    7500 
    7501  out:
    7502         cb->args[2] = sta_idx;
    7503         err = skb->len;
    7504  out_err:
--> 7505         cfg80211_sinfo_release_content(&sinfo);

And we call it again here.  Double free.

    7506         wiphy_unlock(&rdev->wiphy);
    7507 
    7508         return err;
    7509 }

regards,
dan carpenter

