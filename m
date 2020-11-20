Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0942BB599
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Nov 2020 20:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgKTTbO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Nov 2020 14:31:14 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58494 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgKTTbO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Nov 2020 14:31:14 -0500
Received: from mail-oi1-f198.google.com ([209.85.167.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1kgC7k-0002lc-7b
        for linux-wireless@vger.kernel.org; Fri, 20 Nov 2020 19:31:12 +0000
Received: by mail-oi1-f198.google.com with SMTP id q141so4868121oic.22
        for <linux-wireless@vger.kernel.org>; Fri, 20 Nov 2020 11:31:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=fiFuZ808kHqaW9WyZsTE+yPV1m6vflQuPb+JBZiYfIU=;
        b=CGk5BCoesCENi6aMahsTdfR40CvaDzQ/IBYEe6GRZMh4IWLftH6kM0UuiCOkNs6jzi
         qFgohMdB7ObfW7icZFn1N/YdpKytkq+GUY95mSzgrZ3DdNrIw01JdE54fHn3jiSky4DZ
         OohDXbs4B+Z9plsZydBfOrWaiS9vq44DccyY+KeGD9seAKW6N6bfqHnDYmzb5FUi+XMH
         kx8E6PD0XgPrTTGAwyyrdQRAvVoAytn/NR5IZ4dK2pVCBoFyr5DLyrX5K5vQN2kkyhYI
         jTxaU+EVHFy8FVc0WrAeUF3CMskHNEdZXvCOppFOG1hvBGPNu+h7IhZ0cSp07BfboHgu
         rlbA==
X-Gm-Message-State: AOAM5303SUci/xQKiFTtFKY1SaR9FUrw0GlwuV3WKAiFD7nKiWYZEk4/
        YmjC4jOS5/63HWu54uajTWc6jK0u9AV5VlLTWqImeZHMGdQ2lzywGH/EH3RZL7PFbugNfR3Nb/1
        8S4n1Agrk+CfVLIkJmjSRNFVUM1bN+H7TaVZZ5hYKCVbP
X-Received: by 2002:a05:6808:8ec:: with SMTP id d12mr6855086oic.150.1605900670766;
        Fri, 20 Nov 2020 11:31:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy91fEPTNDp0gVzoGsk+hSeNdqQwPzEvXPsMQH7X/lX4Z9LdbCjiO0OoysOqADdfcR5+fieMQ==
X-Received: by 2002:a05:6808:8ec:: with SMTP id d12mr6855075oic.150.1605900670523;
        Fri, 20 Nov 2020 11:31:10 -0800 (PST)
Received: from localhost ([2605:a601:ac0f:820:1158:e034:1c89:296f])
        by smtp.gmail.com with ESMTPSA id w64sm1137928oie.49.2020.11.20.11.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 11:31:09 -0800 (PST)
Date:   Fri, 20 Nov 2020 13:31:09 -0600
From:   Seth Forshee <seth.forshee@canonical.com>
To:     wireless-regdb@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [ANN] wireless-regdb: master-2020-11-20
Message-ID: <20201120193109.GP5439@ubuntu-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

A new release of wireless-regdb (master-2020-11-20) is available at:

https://www.kernel.org/pub/software/network/wireless-regdb/wireless-regdb-2020.11.20.tar.xz

The short log of changes since the master-2020-04-29 release is below.

Thanks,
Seth

---

Abdul Rauf (1):
      wireless-regdb: Update regulatory rules for Pakistan (PK) on 5GHz

Pavel Starosek (1):
      wireless-regdb: Update regulatory rules for Kazakhstan (KZ)

Robert Marko (1):
      wireless-regdb: Update regulatory rules for Croatia (HR)

Seth Forshee (3):
      wireless-regdb: update regulatory rules for Egypt (EG)
      wireless-regdb: update 5.8 GHz regulatory rule for GB
      wireless-regdb: update regulatory database based on preceding changes

bkil (1):
      wireless-regdb: restore channel 12 & 13 limitation in the US
