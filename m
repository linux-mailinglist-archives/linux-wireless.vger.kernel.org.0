Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7862DD16E6
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2019 19:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731145AbfJIRh1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Oct 2019 13:37:27 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45615 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730256AbfJIRh1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Oct 2019 13:37:27 -0400
Received: by mail-ot1-f65.google.com with SMTP id 41so2419492oti.12
        for <linux-wireless@vger.kernel.org>; Wed, 09 Oct 2019 10:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vDM+CarZpD4PVOINcjlaQm6NSCuV8vHz1MDwtVy/sAk=;
        b=EIJVLVUus/WWDpQvLrjZuiCm33ZQmc5oeKZUDlIpbV5DEYex9hRmYohMnTU1DI6+re
         E7BVcv1QqtMXTouuAemnpM1umIJzcs88LCxYLLo69BSceh0cReLHrbTo1dXUpjpcHZeT
         TvrbCf0XlJEpYECjkjrVzGDnTHv02pu4wjyC4CVyWtcZWy2sLuBAMbDHK/3O7gmdciV2
         3KHcmHNZNRsVWol06oxNKBu31r7Y3io7M4gDGVHAGs/tEYCIICVhLSisyNv3NnqSr91t
         IwcRDhXjM+2Fl5/Jecqqt/XdeE5L6N5GfGhoy50zshpruRU/qFhr19nwTVTXt2FRN/0S
         M8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=vDM+CarZpD4PVOINcjlaQm6NSCuV8vHz1MDwtVy/sAk=;
        b=YPg2uqKOVIk9wlec7fA6zs0o041BYmFhzu7Ue0ttNdKz4+rZQe1Wge9rOG/FHTi5iG
         kimMhsaP1OBHCo9ay1s0bD70KwqY+b26FuRqCTeiPj02gDnbvwa7wTTgRFnnAYa2Km4i
         KDyKYNDDTXLYZwgAyfTnUMIB1US5xuHFRfINjB/YsQpffXvuvGqlhXuLecaY+qMLZndF
         RfCHf7MAy7xglby4GLW1PqK/HtV/DGtPG45wdYycw1ydSp1wq5EFwlfifTX2N2qmVrBT
         h+4iVpkgsQT90roHxKW+vDHukrBz1ig+g9pgDt0cJ4/iOh7UwTLUN02Y0Zf+LEGKyeGq
         HrFw==
X-Gm-Message-State: APjAAAUkJ3bJ4vhUHmlR3ZFTM3I2FOy03DW7WXbT1Ow/PeVmV7sxetNA
        y0bXq7VugsSr7dukAAeVUTQ=
X-Google-Smtp-Source: APXvYqxQx50CNgAqQ2/wvDyRRM2jheBiNiTjDXgR16CoAFNjkb4h7h8QonoJAsBlix18m9TWFUjQ+A==
X-Received: by 2002:a9d:70d0:: with SMTP id w16mr3817076otj.107.1570642646673;
        Wed, 09 Oct 2019 10:37:26 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id s66sm848199otb.65.2019.10.09.10.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 10:37:26 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 0/4] *rtlwifi: rtl8192se:  Replace local TX and RX bit manipulation macro
Date:   Wed,  9 Oct 2019 12:37:07 -0500
Message-Id: <20191009173711.20348-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

These patches are part of a series intended to replace the bit-manipulation
macros used to set and read the various descriptors with a set of inline
routines.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>

Larry Finger (4):
  rtlwifi: rtl8192se: Remove unused GET_XXX and SET_XXX
  rtlwifi: rtl8192se: Replace local bit manipulation macros
  rtlwifi: rtl8192se: Convert macros that set descriptor
  rtlwifi: rtl8192se: Convert inline routines to little-endian words

 .../wireless/realtek/rtlwifi/rtl8192se/def.h  | 619 ++++++++----------
 .../wireless/realtek/rtlwifi/rtl8192se/fw.c   |  31 +-
 .../wireless/realtek/rtlwifi/rtl8192se/trx.c  | 189 +++---
 3 files changed, 375 insertions(+), 464 deletions(-)

-- 
2.23.0

