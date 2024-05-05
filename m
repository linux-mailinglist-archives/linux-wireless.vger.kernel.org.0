Return-Path: <linux-wireless+bounces-7196-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A708BC012
	for <lists+linux-wireless@lfdr.de>; Sun,  5 May 2024 12:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85BCA1C20A42
	for <lists+linux-wireless@lfdr.de>; Sun,  5 May 2024 10:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4211096F;
	Sun,  5 May 2024 10:37:37 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14695566A;
	Sun,  5 May 2024 10:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714905457; cv=none; b=nV0VKWXgvvc/oOTYKmClgse46pvMmvdQNbOcUzENDGg42yxUozYDohdca3aq934i/HU0IG11OM1OZT74zyKaf3QWwwCrAoT0hVmlKcyDpmBt/azqCFwWkaXKoAvP3sI40Kkc6OKcyF0y4JgIE+31c80FtTcHiDvvqIMeAI0UkTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714905457; c=relaxed/simple;
	bh=4dGJOao/e2udAoNy0XvUDEsCmbPxU6hDszjW6HEIw/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LdsEBJ8jDYiOvQuN3B7ZTN8EVoxpx6VgUtdo1NBs5pl82Zn0uzmhd+GcbGjShok69juG4PyJuSnfH+1H/m2m+gl3RauNoF4i4HQOedpmVdSO/sS8WUBo7w+WRh7oZ1Dhs4h1CUqeIRh+whAP+dmWpn2xn2PQrkId1eOfHB0/lwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav414.sakura.ne.jp (fsav414.sakura.ne.jp [133.242.250.113])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 445AanF2024438;
	Sun, 5 May 2024 19:36:49 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav414.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp);
 Sun, 05 May 2024 19:36:49 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 445Aam07024433
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 5 May 2024 19:36:49 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <6d10f829-5a0c-405a-b39a-d7266f3a1a0b@I-love.SAKURA.ne.jp>
Date: Sun, 5 May 2024 19:36:49 +0900
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] nfc: nci: Fix kcov check in nci_rx_work()
To: Ryosuke Yasuoka <ryasuoka@redhat.com>, Jeremy Cline <jeremy@jcline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "David S. Miller" <davem@davemloft.net>
Cc: syzbot <syzbot+0438378d6f157baae1a2@syzkaller.appspotmail.com>,
        edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
        Aleksandr Nogikh <nogikh@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Dmitry Vyukov <dvyukov@google.com>
References: <0000000000007b02500614b66e31@google.com>
 <550cc81a3dffd07ec1235dc32fd7bbde22d9bf57.camel@sipsolutions.net>
 <CA+fCnZe_fuT2y4ryFeb8A49k19MY3Nct79JCoGwQh0hjcq6bqA@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CA+fCnZe_fuT2y4ryFeb8A49k19MY3Nct79JCoGwQh0hjcq6bqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Commit 7e8cdc97148c ("nfc: Add KCOV annotations") added
kcov_remote_start_common()/kcov_remote_stop() pair into nci_rx_work(),
with an assumption that kcov_remote_stop() is called upon continue of
the for loop. But commit d24b03535e5e ("nfc: nci: Fix uninit-value in
nci_dev_up and nci_ntf_packet") forgot to call kcov_remote_stop() before
break of the for loop.

Reported-by: syzbot <syzbot+0438378d6f157baae1a2@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=0438378d6f157baae1a2
Fixes: d24b03535e5e ("nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet")
Debugged-by: Andrey Konovalov <andreyknvl@gmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 net/nfc/nci/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 0d26c8ec9993..b133dc55304c 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1518,6 +1518,7 @@ static void nci_rx_work(struct work_struct *work)
 
 		if (!nci_plen(skb->data)) {
 			kfree_skb(skb);
+			kcov_remote_stop();
 			break;
 		}
 
-- 
2.34.1


