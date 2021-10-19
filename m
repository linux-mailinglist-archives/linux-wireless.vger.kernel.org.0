Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B49D84340B8
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 23:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhJSVo4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Oct 2021 17:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhJSVo4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Oct 2021 17:44:56 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81C4C06161C
        for <linux-wireless@vger.kernel.org>; Tue, 19 Oct 2021 14:42:42 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id nn3-20020a17090b38c300b001a03bb6c4ebso960612pjb.1
        for <linux-wireless@vger.kernel.org>; Tue, 19 Oct 2021 14:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=qOouh8K8sZfZnSOuRjANJn5kqxbGB0K/IS/bI+y2tIQ=;
        b=YX7XIxSBF6tCdBnEZcN8S9Jl+/EFuo79FbaP1JzPBZohsm5GE5/bNHZWq2iggVkGyX
         cfDX+uOde4XXrQdaisBXIftHBaXNFIeqQ7dzAnhK/BYjefS4D/N0Sjq1slMrey1zZ1Kp
         N59TkvHeSFAipRX0RhrQOX+QUXvcwOLV4swGxhGHt6mp6DbEIDkw1LGR9DGjo4s4ltfX
         lzMVdaKpxUL4Y52plYYKBUTwk+Vda4BCxqyH7M9Vb5dOnqh6MY2j1aqDl1MhiHopnIpm
         RthXUBbe6h+oimL6b13hjHfx8yd7IPdvnjSFcVs+u6xidw3uJpRPHPg4zpq1JIVc0bJ0
         Slsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=qOouh8K8sZfZnSOuRjANJn5kqxbGB0K/IS/bI+y2tIQ=;
        b=joYoy3mn7svLI2Pun1x0HRGTa3r6OuALBNDWjY82RyXnVsksZkY1BsuQh/K7t83TpG
         iL9Jr2ElXsavHBMgE/MFE1s0j6fVsQAorR/VGrceGFdgRxPQLfNEqFNFBFpAbykZqcds
         olxcFL9an1ijIGA7Dg417xPQmvx//Ey7wlYTVK4C9FjiVSex2dBKgq/QHslUC/Usepq6
         tsdytTGoRtssKWsGBF2wxkKtLIJlPLyY+lClNdlbj6CZnS9yUD7ZORlPhKMTqcYW8fEe
         9iLQTMWsxPQAYgcwM1xqXUMRNQ675CIn+Zue0Ey3jeFLOf6+Z2l0eL8uRrX/BTzZOVDR
         MnUQ==
X-Gm-Message-State: AOAM532w3tPkFDNFFFw3NVp/LWleyqwyDUYUnOrkAsQrZjgN939xYABU
        pGhv4pM0NsHamvUnYNocALtD3fIL03Y=
X-Google-Smtp-Source: ABdhPJxYwz+4Mld1iHqX1qVYDXoLJOTnU5GI+ptFIMvkpMvYUwGxPy+cUDxPDIGymDmqFIBok7XyLA==
X-Received: by 2002:a17:902:c443:b0:13f:5507:bdc7 with SMTP id m3-20020a170902c44300b0013f5507bdc7mr35299341plm.50.1634679762198;
        Tue, 19 Oct 2021 14:42:42 -0700 (PDT)
Received: from [192.168.254.15] ([50.39.163.188])
        by smtp.gmail.com with ESMTPSA id a21sm105840pju.57.2021.10.19.14.42.41
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 14:42:41 -0700 (PDT)
Message-ID: <14719251a15175e3ddf0dcb67ff0804073332898.camel@gmail.com>
Subject: Bug - brcmfmac fails 4-way with OCVC set
From:   James Prestwood <prestwoj@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Tue, 19 Oct 2021 14:39:20 -0700
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I've noticed brcmfmac (offload) fails the 4-way handshake if the OCVC
bit is set in the RSN. Hostapd rejects because the card did not include
the OCI.

I would expect the card to:

a) Include the proper OCI
b) Reject CMD_CONNECT if OCVC is set
c) Re-write the RSN to not set OCVC if the card is not capable.

Thanks,
James

