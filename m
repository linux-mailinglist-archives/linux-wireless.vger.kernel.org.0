Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 825343547DA
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Apr 2021 22:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236723AbhDEUyn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Apr 2021 16:54:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44258 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232553AbhDEUyl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Apr 2021 16:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617656075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=r3zNk6MN5CIEDxdVyZSkB7bovLWFRZK6WzDPtyWI6ag=;
        b=fEsIFIZLurVIlirPHjy2k61Zq/1cFC75R0ZovijralrBNpJhK96Gm2ddR9893vWC7QfeG5
        qMeVTI1WIIVAC8ucNtktMKmhUlpLO/OU11AxVqDfspmrRVCbwVUIkvhsuR7KQTzGrm6bWk
        m4kpiEKCc7QIHTDMuzBLL9+EypEHLP4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-5lT8rkfLMSOPSM2cdm8e_w-1; Mon, 05 Apr 2021 16:54:33 -0400
X-MC-Unique: 5lT8rkfLMSOPSM2cdm8e_w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED3AD9CC00;
        Mon,  5 Apr 2021 20:54:31 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-31.ams2.redhat.com [10.36.112.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0FE565D9F0;
        Mon,  5 Apr 2021 20:54:29 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Chi-Hsien Lin <chi-hsien.lin@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>,
        linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com
Subject: [PATCH 5.12 regression fix resend 0/1] brcmfmac: p2p: Fix recently introduced deadlock issue
Date:   Mon,  5 Apr 2021 22:54:28 +0200
Message-Id: <20210405205429.19304-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Here is a resend of a regression/deadlock fix for 5.12 which I send out
around rc1 but which still is not in Linus' tree.

This is quite a bad bug, breaking things for most broadcom wifi users.

Can we get this regression fix on its way to Linus for 5.12-rc7 ASAP
please ?

Regards,

Hans



Hans de Goede (1):
  brcmfmac: p2p: Fix recently introduced deadlock issue

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.30.2

