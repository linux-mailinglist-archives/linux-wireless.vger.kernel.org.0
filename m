Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7246AB473
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2019 10:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731857AbfIFI4N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Sep 2019 04:56:13 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:43483 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbfIFI4N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Sep 2019 04:56:13 -0400
Received: by mail-lj1-f169.google.com with SMTP id d5so5254961lja.10
        for <linux-wireless@vger.kernel.org>; Fri, 06 Sep 2019 01:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=tr7X7vxz4B6k5MSHYxIPNslcn8xvWfQFZQgcB5nf0II=;
        b=QBYgzARbRX0ROArTKSyh5O9+MnyrodLnZvT7Z4ut6PIH12iOE2HYTUHaeL8QTGhv3m
         DQaCvin0ieLts0QCWkaYrvydanQxasTgYgEHEUmiCwFQzXu5SBnpAWqLrruka+SNGEdH
         diEXhz0j+SuBm1GeMywQz/2EBPFFHKwIYdkCtUZ/YOvbMWo+pQ6GdDhb7Ydh5Drzopap
         7QUcuF9y739kImt1fGwsJd5IvSycF5mF4hapZuzyb++oMLJEOHsbx3DDJDSahrsyp8hJ
         0Nqp/462Q/G5MBpeeRur1Vfoq/5c15vK6UYojhJXvr8oGXaugHt6ti91trprDpa7FFZ0
         D/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=tr7X7vxz4B6k5MSHYxIPNslcn8xvWfQFZQgcB5nf0II=;
        b=q7cQfGWOOrKM7SrPMI9jhlA2btkfoQb7tZpci0czei6GKW7A1r/0cGz6YmVwqqZPX+
         KmsW2ng0AgEYHcNoRoymxf9Ajqj1teF8eTIfKUS3UgRhX2BRZDVe2xjOHGGlQyfcIZkX
         f1JcYeakNC/hjhZwY+j3I7DGlZnoPDCdwjOWzloUXzpib2oZEtm7DrLujJKRUrDfDL7c
         6PPoYgbuKVR2LGLEAZIa9OR+m6t0QGn7ohbV5HSEfvs5xd+XD57F4yUeGFh1M+rOxqqB
         UhWH8Q8UtH1G7zv+rJVFXSZZdvdyYTJ2hMoCzMJLAOJVfuBHPPGQmkiaEznjZvOnOjgd
         BFDQ==
X-Gm-Message-State: APjAAAVBXMs+xzaKDV8RfUBoj1LSN3S4wo57Hnjk6FTdYnRt04czhX8P
        xuRqdWs1m//G4585pvpgejo/tvHdsw8hgutsSDMIVJQN
X-Google-Smtp-Source: APXvYqwf+GTojTz+2cV2ZIvdkOWY8vLW0MxalR/k2/AZd3ePfTSjRu8IYYbXApc0gnn5p1nHAYrbXS81Q9XZA/LoyVo=
X-Received: by 2002:a05:651c:95:: with SMTP id 21mr5176134ljq.128.1567760171197;
 Fri, 06 Sep 2019 01:56:11 -0700 (PDT)
MIME-Version: 1.0
From:   Luis Correia <luis.f.correia@gmail.com>
Date:   Fri, 6 Sep 2019 09:55:35 +0100
Message-ID: <CAHJ2opv5fhURr7f9H7fbXZpkc6NowTkDtrZ0Xa743DKKf9HquA@mail.gmail.com>
Subject: [PATCH] CREDITS: Update email address
To:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Luis Correia <luisfcorreia@gmail.com>

---

diff --git a/CREDITS b/CREDITS
index a738760..8b67a85 100644
--- a/CREDITS
+++ b/CREDITS
@@ -751,7 +751,7 @@ S: Santa Cruz, California
 S: USA

 N: Luis Correia
-E: lfcorreia@users.sf.net
+E: luisfcorreia@gmail.com
 D: Ralink rt2x00 WLAN driver
 S: Belas, Portugal
