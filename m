Return-Path: <linux-wireless+bounces-20714-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80417A6CF11
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Mar 2025 13:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8EAE16E792
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Mar 2025 12:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751AF13BAF1;
	Sun, 23 Mar 2025 12:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G59ocVhh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B813635946;
	Sun, 23 Mar 2025 12:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742731225; cv=none; b=ejYPzAzib2RO/BCjwZrHbSzzSJPCvZ5aJM801oxS/1a3J4jiUBNoa1WPxmYN1oUkH8ec3cSDTViP+JN2ZHFz40N7daR5D8nnf8YJMFr4sY9WnspH68p+0hMQsjHcUGnRNiyWFIgbKvuYc78uGofooAeX5hMfIySNXe1ZkQBak1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742731225; c=relaxed/simple;
	bh=dV3WY7g5AgUsIPaJZLeXXgOiR4cISl+ezx0RCzVdEm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cKueDfteDxLYB6q3q74u7+FKs9v+fqbkzEsQCYe8Hw7dq7BYSpHfTtHxFDBm5e0js1dFskvD9qmXJCMKNbCSfzzDBoygRrpmNzfW109722ETqyQChLTLvLpT94TeHLtKbb2q7kN1mqzDB/KqiQQfwTSe3+7MDZUBESn2CEVr7dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G59ocVhh; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac3eb3fdd2eso501125066b.0;
        Sun, 23 Mar 2025 05:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742731222; x=1743336022; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GrafXZ+fTOV5Q0yOHTKTlBFYtkynKxA292LQeLGoU8c=;
        b=G59ocVhhLJL7IuEh3u7b07we7i6uARvibaweXtFI0x8TyO+NsXvky3qYVhxjvTwUIB
         dwWiHErebCOxA4edFLBBCdwW7edEGsAyjY6Lmsvl6iA3dlHRGq7biZbpWRARz+DtBQkt
         r70GKbNdp9QotZfvoT3s1QVnfFgFsjR0ChlarPkSnWoBiHVWM5n4jp3qH3kdqQHFuE8i
         wD58fqCbpqxJcrf1zhQZyAMMQLzeiCSt3CfFsWL6Owot1pP/M6pVBn0zjPM63OYREGW3
         Vj+bI6LKGHgmo2LyU1P8mxZaXKmhnEBL0wd4QPqp/KcwpyIcrB/FQBFfhyEJzq2PUFjp
         cjvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742731222; x=1743336022;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GrafXZ+fTOV5Q0yOHTKTlBFYtkynKxA292LQeLGoU8c=;
        b=H2qBNHMYgAWWuwOo4YDtcr8nWgmyydg+ELsodgwza8K+VzfEU+jYbpl7PRE0CZoBu5
         32Z65zS7MgkctFnVc/Xie68WNyImlrtawxSsLbYvRNxYCtgQM3WaqoPYgRCFk1tpGG9t
         XrKfnNsgwCj6SvbMBT5bGiEuMWzBI2FVInxyALvF37BwZ/PhZCYntAXTPl6cawF5EUIV
         uvylxF7/JjWZZ7o8oxuLqrZp4QWhGVZ+LKao4vq8PJhDqYQQOskEolD1Swkty0LZhyc+
         ldzaF8AsFLqNYC9ZjJmowUK9zU5mbibLFXDcbZglvNS8lwL5LmhV7/ADtL0zKtFVqf8R
         vzvw==
X-Forwarded-Encrypted: i=1; AJvYcCU2KQ+3cWjBmJjz4OPkR94MQdy1b5wBZF3DPvKn61MdVaqA0PIAG66KlwSaJOLcZduBABVgb59sZukFDrCM1wU=@vger.kernel.org, AJvYcCWdKAUmetyjRFVqmUz5queP5bR1PGSiQeEMqDA/A9wtqq9jAdyrtQ1N4PJN1gVylvhKXNkq9igBnMigQZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdKPbEL7NM9bG+jhH5X7V1CfGCZ8hl3hjMM0hVawAc0orC/nuZ
	DAcs+0IeDUA9VY1+0HurkN30zSL/7fzzP8QJgvJXUTpa6zqdq4CmSQOPWabzpOIDpl77Z/QnQQA
	ZliRRGm9fKQicx8mNkniKrlVIRflQSZQI6HU=
X-Gm-Gg: ASbGnctt1HbUZeBkjzHzvqNpMR/WFuOMFtoUUpZsho0+71RupeT2WsGUx//KyAIvWOg
	D9qZRUTrvlhgU6s8ZHJVPUlvk7KfKxw4l+Vo5mKASss0bRWBe+eAzIeoiKsjQsHOWsYc2gCTroa
	QF2czNCAc/FNrZa7cZlMo2hiznAw==
X-Google-Smtp-Source: AGHT+IEmwD9GqpgkQgN9NorTx5No1B/GDt3L++LgVtbFkWOFIhvRhQ5KQtfTXg5yPa+PtmUd4Pl7jRU5RvGVuuQ4xus=
X-Received: by 2002:a17:907:a58b:b0:ac4:3d0:8bc9 with SMTP id
 a640c23a62f3a-ac403d08c9dmr677975666b.27.1742731221681; Sun, 23 Mar 2025
 05:00:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250322141910.4461-1-qasdev00@gmail.com> <d1df5d97-4691-40d4-a6cc-416505f35164@web.de>
 <92d1a410788c54facedec033474046dda6a1a2cc.camel@sipsolutions.net>
In-Reply-To: <92d1a410788c54facedec033474046dda6a1a2cc.camel@sipsolutions.net>
From: James Dutton <james.dutton@gmail.com>
Date: Sun, 23 Mar 2025 11:59:45 +0000
X-Gm-Features: AQ5f1JqVpB_XbQHhuZx8L6OtYWjrN2ZY-NMIq6Iv9-4jH4hsP7HUUWJ477xKkmg
Message-ID: <CAAMvbhGrJ9b3Aab9+2a5zmvEgf0GZFmHLCC7Hud+egUE28voHQ@mail.gmail.com>
Subject: Re: [PATCH] wifi: mt76: mt7996: avoid potential null deref in mt7996_get_et_stats()
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Markus Elfring <Markus.Elfring@web.de>, Qasim Ijaz <qasdev00@gmail.com>, 
	linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, 
	Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Bo Jiao <bo.jiao@mediatek.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Felix Fietkau <nbd@nbd.name>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Peter Chiu <chui-hao.chiu@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"

As a security side note in relation to the following patch:
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 66575698aef1..88e013577c0d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -68,11 +68,13 @@ static int mt7996_start(struct ieee80211_hw *hw)

 static void mt7996_stop_phy(struct mt7996_phy *phy)
 {
-       struct mt7996_dev *dev = phy->dev;
+       struct mt7996_dev *dev;

        if (!phy || !test_bit(MT76_STATE_RUNNING, &phy->mt76->state))
                return;

+       dev = phy->dev;
+
        cancel_delayed_work_sync(&phy->mt76->mac_work);

        mutex_lock(&dev->mt76.mutex);



Prior to that patch, the code looks like this:
static void mt7996_stop_phy(struct mt7996_phy *phy)
 {
       struct mt7996_dev *dev = phy->dev;

        if (!phy || !test_bit(MT76_STATE_RUNNING, &phy->mt76->state))
                return;


The compiler will completely remove the !phy check entirely because of
the use above it, so it being present in the source code is completely
bogus.
If one actually needs a !phy check to be present in the compiled code,
one must arrange it as per the patch above.

The fact that the !phy check is in the source code, implies to me that
someone, in the past, thought it was necessary, but I think an opinion
could be taken that it is there to obfuscate a security vulnerability.

Kind Regards

James

