Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1AB43D8193
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jul 2021 23:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbhG0VTZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Jul 2021 17:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbhG0VQx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Jul 2021 17:16:53 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC363C0613C1
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jul 2021 14:16:52 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id f13so73679plj.2
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jul 2021 14:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QuYl5+rTP/+R/3rDjAm0Jnl1lTT65zBH39RH5WLEAR0=;
        b=bRfqHarnmPtbXc99uxZdsY9MdvKd7uoSqaqt1wLCu/SnB5hUsRQWrev8b/IdeSWVBf
         zS4Zn6K2vFy+movGd0fhaQNE+NIQdFZmFCDXR3gze9QBxEp0uVz4CDxUCOwITpRdomYG
         6sypVj5k4QzD9dhhAk7Jvl/jrcTzj2mToflF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QuYl5+rTP/+R/3rDjAm0Jnl1lTT65zBH39RH5WLEAR0=;
        b=DHMjWyt3aXZnWnIyj+4k1hnovpF7+SIwoLcXGVFsqRQc608uUApZbIhySSF7XH0AhI
         6JDX6dPZQqIy1OlUNsUhbzB/LD+CZJBj8+IWGMy1we//mdd7wcBdsDh6RBnMpC+coziP
         +U8Wa4Q8gd4juJX3lySe6SuzR/ODTUgHV8RbfpCEz/OsPVno0YZF+a/jLs55xrU8Oi8J
         Ovih64CvsfeGQ7xek24fuEOgMEVkubV2VQ0WENZVPTLktoOv0KGQ2p6/Y9tujXd9Ycac
         +LVJULqwAIEyInWbVsmqDTRZPsKH2upcw4PxxtISNibM16cgZ9aX3p754zaUAVXf59f7
         Sj8Q==
X-Gm-Message-State: AOAM530O4YwgpyTubMKPWnPY80B+mHyCerN4IxB3rmlab4FPADPHmwPL
        WVpxiaXGqtH0KxiFGLdvV1qVfg==
X-Google-Smtp-Source: ABdhPJwEiKDql2p5UPYuPWyvuzD1+aLXfJp0O+mcTJHzcnlDiJH7IYgZlBI2bLoSa3DFZocqXKWiZA==
X-Received: by 2002:a63:134e:: with SMTP id 14mr25120786pgt.312.1627420612398;
        Tue, 27 Jul 2021 14:16:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y9sm5034698pgr.10.2021.07.27.14.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 14:16:50 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH 36/64] scsi: ibmvscsi: Avoid multi-field memset() overflow by aiming at srp
Date:   Tue, 27 Jul 2021 13:58:27 -0700
Message-Id: <20210727205855.411487-37-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727205855.411487-1-keescook@chromium.org>
References: <20210727205855.411487-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1097; h=from:subject; bh=Nq1NUVDlF5HB2sL3wLI4PgmWfjw6IdyQL7mY1ITGnck=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhAHOI21reOQg8BrkfHddEuElFGDIapR2heYw3xo22 cpdsHDuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYQBziAAKCRCJcvTf3G3AJvhsD/ 9f+BKlmaFnyRZQcn1rlNDY2vh+rNTRxOLWqPkDfUPDZZ97wHv4DBEpdLaXiuhCZf608S+816myOXX+ nT5UFOcdgLS8KSNQsCYAiZ8y6i6Tg4+eSRQunUnuVzVL3O98L0xqB46WaeeYx70RA6j5DnKbLOchNN AjaSeeQx0pnsg9cSycqn8lvZyqETRhU90TKbfnJtqIX4NEONgrTzdm8ZKbhe4RYUabvOxhjbiw7+j9 yYitnuR8to7ti1pifqARyJJrmpvyFicfspMm+frwRLM1W6LA/s7nG8iAQ5sTn/uzoB9cCj+SweTPkR m+AsViv0F1qTlCBahXchUqn2qo8JD0BZvitJ3EW1JR1OuFzTXkm4GT0+sh7Nv+hcTpQyriLzuTKuzz 4K32VkFr/Ngh4JofcvGrq47NeW+rPy+OefZwviXvKsNZmypkxuWROPihUMZHdjHbE7DCVwLoKFC64l rmccyM+XL5CwKYV01CmnjIZnKBVjuCh5PKcGpt7afr5ogG6tc2TUnvcY8lifwBGzsgS0nVOPT47wjG me8YQ4+eL1qJGzSl6NZ2krfvFMNxWRLa1UuLhO6PDmXxr8+1VYVWWQltkkcbKYEWarHuOvOxN+DOaB KeSbdbqc2xxk6w2cz+t6Eez7On01QP+vgWhE9arlnKCLSEH75mw7tmX/ZlrA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memset(), avoid intentionally writing across
neighboring fields.

Instead of writing beyond the end of evt_struct->iu.srp.cmd, target the
upper union (evt_struct->iu.srp) instead, as that's what is being wiped.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/scsi/ibmvscsi/ibmvscsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
index e6a3eaaa57d9..7e8beb42d2d3 100644
--- a/drivers/scsi/ibmvscsi/ibmvscsi.c
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
@@ -1055,8 +1055,8 @@ static int ibmvscsi_queuecommand_lck(struct scsi_cmnd *cmnd,
 		return SCSI_MLQUEUE_HOST_BUSY;
 
 	/* Set up the actual SRP IU */
+	memset(&evt_struct->iu.srp, 0x00, SRP_MAX_IU_LEN);
 	srp_cmd = &evt_struct->iu.srp.cmd;
-	memset(srp_cmd, 0x00, SRP_MAX_IU_LEN);
 	srp_cmd->opcode = SRP_CMD;
 	memcpy(srp_cmd->cdb, cmnd->cmnd, sizeof(srp_cmd->cdb));
 	int_to_scsilun(lun, &srp_cmd->lun);
-- 
2.30.2

