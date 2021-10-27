Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0994243C2BB
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Oct 2021 08:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238403AbhJ0GPF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Oct 2021 02:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbhJ0GPE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Oct 2021 02:15:04 -0400
X-Greylist: delayed 51457 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 26 Oct 2021 23:12:39 PDT
Received: from dvalin.narfation.org (dvalin.narfation.org [IPv6:2a00:17d8:100::8b1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BB3C061570
        for <linux-wireless@vger.kernel.org>; Tue, 26 Oct 2021 23:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1635315157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cLQgxbguMF5yRz6B5r/t+4rHgZszOSE0MY7PRGpztiU=;
        b=VD08oWPbGskSBC5Hbk8ZE1I1vXKcM5kfevoxFhWqAlkiXYSvenlWDJpiVlLTOGDsLpqbgl
        tm+j0n2AYgmC4luQdTaIOoaGLQjwfo6zCWQ3bjJtP3kTiorLgd/wc5VptppNtGDlh7ODxa
        OwrwWfL7lwKPPFom8WqizNf/n4TFsl0=
From:   Sven Eckelmann <sven@narfation.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Karthikeyan Kathirvel <kathirve@codeaurora.org>
Subject: Re: [PATCH] ath11k: clear the keys properly when DISABLE_KEY
Date:   Wed, 27 Oct 2021 08:12:35 +0200
Message-ID: <26869605.A2Tbvc0WiF@ripper>
In-Reply-To: <20211026155446.457935-1-sven@narfation.org>
References: <20211026155446.457935-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tuesday, 26 October 2021 17:54:46 CEST Sven Eckelmann wrote:
> Tested-on: IPQ6018 hw1.0 AHB WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1

I would like to retract this Tested-on. My test caused another problem which 
resulted in a complete shutdown of the vdev. After fixing this problem, it 
turned out that this change didn't fix anything (as far as I can see) on this 
firmware version.

Kind regards,
	Sven


