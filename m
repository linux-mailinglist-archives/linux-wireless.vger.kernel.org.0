Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC7E5E165D
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2019 11:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403978AbfJWJkW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Oct 2019 05:40:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48884 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729191AbfJWJkW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Oct 2019 05:40:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A4D2D60D7D; Wed, 23 Oct 2019 09:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571823621;
        bh=HOW90wRsi8O+ak3+5Nx0Jma9uwcapHRfW84/YruUO9M=;
        h=From:To:Cc:Subject:Date:From;
        b=J+GdQeQDCpxWjGYbkU1Ui8qzawPgxJCfDfcdBB3IsN4Ay8hztt/LVI3VxY1nnPKNH
         xf3iuGZwe2kXQySG3H4lAxnK6sG7IRgx/kWNn2IXWIeYoZwffE5qsSIDe9g9uL+jGA
         HAtmX6WRgmORaRyBt+8tYaiP4r/ZJzVb/3jtMxJk=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from govinds-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: govinds@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3059660D7D;
        Wed, 23 Oct 2019 09:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571823620;
        bh=HOW90wRsi8O+ak3+5Nx0Jma9uwcapHRfW84/YruUO9M=;
        h=From:To:Cc:Subject:Date:From;
        b=U1qmH+3+PoufmJLNrUMjQT5/stMAQprPJv+eO3Sn6Qz/v+V2FAj2BWBroNeNd9rNf
         ykLy1ZvPyhG09Xy5llp2K7DODk+zU18/6C8+E5FrViecb20FL21H0+Ui86jlKw0orT
         yfX3S86ZnnmK6iPYiCrkc75n6ZHyLebmXZjxN8U4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3059660D7D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=govinds@codeaurora.org
From:   Govind Singh <govinds@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>
Subject: [PATCH 0/2] Don't call SCM interface for statically mapped msa region
Date:   Wed, 23 Oct 2019 15:10:12 +0530
Message-Id: <20191023094014.28683-1-govinds@codeaurora.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For some targets ex: SC7180/QCS404, SCM permissions for MSA region is
statically configured in TrustZone fw. Add SCM call disable option
for such targets to avoid duplicate permissions.

Govind Singh (2):
  dt: bindings: add dt entry flag to skip SCM call for msa region
  ath10k: Don't call SCM interface for statically mapped msa region

 .../devicetree/bindings/net/wireless/qcom,ath10k.txt     | 4 ++++
 drivers/net/wireless/ath/ath10k/qmi.c                    | 9 +++++++++
 drivers/net/wireless/ath/ath10k/qmi.h                    | 1 +
 3 files changed, 14 insertions(+)

-- 
2.22.0

