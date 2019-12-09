Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBE8116AFE
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2019 11:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfLIK2x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Dec 2019 05:28:53 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:49049 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbfLIK2x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Dec 2019 05:28:53 -0500
Received: from evilbit.green-communications.fr ([92.154.77.116]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.184]) with ESMTPSA (Nemesis)
 id 1MXGzQ-1iETnT00pa-00YhTa; Mon, 09 Dec 2019 11:28:49 +0100
From:   Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
To:     =?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>
Subject: [RFC PATCH v1 2/4] brcmfmac: Do not allow deleting station in IBSS mode.
Date:   Mon,  9 Dec 2019 11:28:07 +0100
Message-Id: <20191209102808.12014-3-nicolas.cavallari@green-communications.fr>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <m34l02mh71.fsf@t19.piap.pl>
References: <m34l02mh71.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:prXbdW76TtwtqcADBuYpY6/a331iqmlHWd9SZDw51+h9foZvEvo
 yIAw9xdMo3xDG2lTOT5JoPCZI276sWQTJfEG4g1n+Bv8QSUhpDdrdKiu/PMaSFe6tlEm6Zh
 qTj6vJ6AUia2u6p99DREJEdu+viIr66m4T1Q7/ufIRXNMs6CNiGqiODGgVEd5+XcSGh/st9
 x+7Dfwstg7+eADeysV79A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EoeZKTix3h8=:hQlJd2lxRdhE8kLtsTHK6D
 0ATu+qRJNaQak8ROixqrus0fgGKmGkPC/C0Qm9AzegtAY5f3p8XJqMY4xdtsWHgyQh/f2Mzme
 /qom1nPj4p8aBhIKKLqXJBngC0K0kF9ChPqdCuYbgOytNVPsneFm534k6HXbOWAZCa277uA1r
 2XBmp5+f33GVp9caieXCDQ5WeU6zAmRqJvz8wB8blPvObQ7M7ME5wtBVUTQDFWwuZ9zJMOu/m
 ww4tRG1W+Dqc66ZJ5ls4vmL5fxC/XIgZShcth3MYmKWY6CRt+oHvdW0K98qsGpTfPglO5SBS7
 T3jCigPTJMHPs16yLUa6bJJBUPRmfRGBrI+hln06g8qz/Ou6BGQLbGYQ11dCsB7ba19qoccJc
 zxvQMFpiYV9Gor5s7AyoXb+NtW7IEGZXxRpBIYq49ysLyX4adU+OdqItkS8Kvy4iVhPSJ/9U2
 ScnCkUfqzqGDRsTpG95bzGvqUuZWNQmTD3/dLe1m/zTJmkSAF2TfBJB35T2+wg8U8pyiqO4zg
 XWtRW1wwKYr8so1eLHeDSZQ/jmhI+eXhWRWvIo/orwgkVPUmSPMiTLepX8EIkvDgYpiLTQvm9
 6I0jR5nJ5ieYCJUxLcMnI/OW9TeE7uSNHwMmUYIZKIDwk0Nyjq6mVSZvn99+xJCzo/IUKO6VJ
 JJU9lV+dyyiEXurXC88YtK1L8ZISkfxatVjVmXbrCuh8UhmqDVS4+LYABjpHCE+izQoZpXomZ
 5uyS1xvdwzNWgy4GyT9MtoPRLsvIb+NC/XQJeIoWus4uUe5Tuh2h+E1tM+RvNmg0Z78mzsyIx
 w1K7HUSmyzlIPoGIAWipCn2F9VMUwvvHvKCXJ/XuUtdulopaX17WnP59KHBOsR2M8krQUM7y3
 x5m8blQ/DmgGnH4dPDd5TSssVxhJYNP5rPz2cU1m9GArbUdzpJQTyizffuaZir
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In preparation of allowing userspace to explicitly reset station state
in IBSS mode, reject attempts to delete stations in IBSS mode with error
EOPNOTSUPP.

Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
--
I do not know if the driver could possibly support this, so take the
safe route and reject it.
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 5598bbd09b62..5436ffd74ecb 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -4848,6 +4848,8 @@ brcmf_cfg80211_del_station(struct wiphy *wiphy, struct net_device *ndev,
 
 	if (!params->mac)
 		return -EFAULT;
+	if (!brcmf_is_apmode(ifp->vif))
+		return -EOPNOTSUPP;
 
 	brcmf_dbg(TRACE, "Enter %pM\n", params->mac);
 
-- 
2.24.0

