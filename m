Return-Path: <linux-wireless+bounces-27036-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A607AB450D7
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Sep 2025 10:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E307A61348
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Sep 2025 08:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACFE2F998E;
	Fri,  5 Sep 2025 08:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jClDDqbf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469732F99BE
	for <linux-wireless@vger.kernel.org>; Fri,  5 Sep 2025 08:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757059370; cv=none; b=N2nqJo35f526K3Q3F/JnZXi6c6fp6M5uCCOuN86mK+vgF3m2pb2leH396VRUI1yAl1UkMLSCoS2Pt/71aeWWkeb5ylaUOZb1AXf/cQHKC+0ttaeeiJdjCwWiVzv8DdZo1U+OVk3NdiLAuknpq3LDc01srvXdPJFBI3rTtmE5jus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757059370; c=relaxed/simple;
	bh=6RF+gf+/yKBnYeoGU66UQvUIcARgyVh8FRpLL5atQ34=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HMx0E4eSEtvI0a/UQW9TBrg7HqlYpkk22MskqldjUSoK/botSp5tCuugofgidqFIb2RhRpeuo/5TZS+IqBRR0MZgJ4KWC5xDNYWiEAWSwbdP7c4tfin2MvPJcpLAmRxps08D4DScJsbqWY/x7ZeitAsKQv3FBkp33DadVWcLmhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jClDDqbf; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3e249a4d605so1142616f8f.3
        for <linux-wireless@vger.kernel.org>; Fri, 05 Sep 2025 01:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757059366; x=1757664166; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r/fycoWinJYZyk7+UcRLBJI7fmYFDEPrkVVmgpClY04=;
        b=jClDDqbfTwC1NfLwlYVu6A1bkfkryacOXH1wxY513fJaxywQ14WhoGjqKKoEMFaWCA
         rF+b/FKPuPdbDsFUI+pkRL0+7jJ1ujvsYoesOp6OcKsCcXTyR5uKnQNe+ydbxG2HGEoH
         wmLEKiGBPPgaZbrbZLIHJCemPzwiQnm8sP6zyyFfB9ui9umUtdvgD/PRw3Ad78wKoXRO
         i/+pdHQqDMuFXEIKMU8mi8LchCQDpI4geEs4HdVpb9GL/gG1YBL+FKfjRiz598JoOYjO
         kvrUeH2mvrerWJ3qeNDG2trlJV/mQjIvEOArE8HIxcqgq0BLllfnC3FgfRxlpP1LgCSI
         nNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757059366; x=1757664166;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r/fycoWinJYZyk7+UcRLBJI7fmYFDEPrkVVmgpClY04=;
        b=e2nry/SygwGjSBXS1KF0Z234WSGep7fUPd5Cq8n2dYq4lWw1ETOajgrzk2HvYGRebG
         V7WftzAXKSn7ND5I6iK4MHuIV7SUtnJq+55qWlvvFDfgPvKyH4jF+0qeW5Tffb3rOAOu
         maykwl09l8qOcIdd3drocH8lhA5Zi5QrmvUa2itOI6Dn/plW2oJlKYG00PWp7MKlfVQA
         2t32Am+P7V+yoqaSOYmi2a1OaBJ7qvNvmvVioMVofbtwzyp4xCUpORu5raImHMjt4Qpr
         5kxhLUHg3NYoasVsmwzskwX8grAXwpiWRIJA+xv7bdQLpNn6c855dkfgxW8tSgNa8ZBa
         Pqjg==
X-Gm-Message-State: AOJu0Yx5ZAmpwGw0XdeQQBK/xVHzmgjRyqsFM42zl7REftalsbkoF8c/
	CPHetd9IgJ14/62Q3cneoHgU5NSPglB5puDd8akfxUpv1OlIBr5HJZQhz6UtRXe34Fg=
X-Gm-Gg: ASbGncsCtpOI/TR/dgDQTEvTb/09SKaVEd6rH4t9OM2IpNB+l3riu9MABze4ohLB3Qs
	4yTvVKeFNgeBUWbxk9z1qk+67Zd6L6GkKqB/9i9BAZXSktlLKWkdR3xZw9pHZZpXfftBqflDInF
	3sc0TR00jqfTU9fjMJGixPbV75etIB8jE+IUnhaNc9My/JesdjCihBMlZViFUvEMZU2s9ObAyJs
	oqW7Y3QhimwYgH9WZAHIfmLIn1PY51MEvbIf3z4eM7YM3NGMiuak5tpPELX2kXx8CZBcn8fNcVh
	xttpPBvzleh7vN5t6pjqy5kH0cYoFb9JQEhyshcthnzb3MbLk8dsLdkvdPiGkrQO+Y4egk+Duv+
	66fpR2Oe2RnFCJL75+H1AFRqYSpt+KlehSqQOyA==
X-Google-Smtp-Source: AGHT+IGhXGxVxn+hrUNPdqsmX5jWs58uoNXdO8RzoUMS4gm1kXsBhH1MQOpaqkOCq4scW9h70AgM4A==
X-Received: by 2002:a05:6000:2c05:b0:3e4:7de4:8b9c with SMTP id ffacd0b85a97d-3e47de48c00mr398850f8f.24.1757059366517;
        Fri, 05 Sep 2025 01:02:46 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3d0a1f807f9sm29686325f8f.38.2025.09.05.01.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 01:02:46 -0700 (PDT)
Date: Fri, 5 Sep 2025 11:02:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Stefan Kerkmann <s.kerkmann@pengutronix.de>
Cc: linux-wireless@vger.kernel.org
Subject: [bug report] wifi: mwifiex: add rgpower table loading support
Message-ID: <aLqZI4FfOI4iJZtf@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Stefan Kerkmann,

Commit 7b6f16a25806 ("wifi: mwifiex: add rgpower table loading
support") from Aug 4, 2025 (linux-next), leads to the following
(UNPUBLISHED) Smatch static checker warning:

	drivers/net/wireless/marvell/mwifiex/sta_cmd.c:1540 mwifiex_send_rgpower_table()
	warn: not copying enough bytes for '&hostcmd->len' (4 vs 2 bytes)

drivers/net/wireless/marvell/mwifiex/sta_cmd.c
    1509 int mwifiex_send_rgpower_table(struct mwifiex_private *priv, const u8 *data,
    1510                                 const size_t size)
    1511 {
    1512         int ret = 0;
    1513         bool start_raw = false;
    1514         u8 *ptr, *token, *pos = NULL;
    1515         u8 *_data __free(kfree) = NULL;
    1516         struct mwifiex_adapter *adapter = priv->adapter;
    1517         struct mwifiex_ds_misc_cmd *hostcmd __free(kfree) = NULL;
    1518 
    1519         hostcmd = kzalloc(sizeof(*hostcmd), GFP_KERNEL);
    1520         if (!hostcmd)
    1521                 return -ENOMEM;
    1522 
    1523         _data = kmemdup(data, size, GFP_KERNEL);
    1524         if (!_data)
    1525                 return -ENOMEM;
    1526 
    1527         pos = _data;
    1528         ptr = hostcmd->cmd;
    1529         while ((pos - _data) < size) {
    1530                 ret = mwifiex_rgpower_table_advance_to_content(&pos, _data, size);
    1531                 if (ret) {
    1532                         mwifiex_dbg(
    1533                                 adapter, ERROR,
    1534                                 "%s: failed to advance to content in rgpower table\n",
    1535                                 __func__);
    1536                         return ret;
    1537                 }
    1538 
    1539                 if (*pos == '}' && start_raw) {
--> 1540                         memcpy(&hostcmd->len, &hostcmd->cmd[2], sizeof(u16));

hostcmd->len is a u32.  Copying the length into the first two bytes is an
endian bug.  It won't work on big endian systems.

    1541                         ret = mwifiex_send_cmd(priv, 0, 0, 0, hostcmd, false);
    1542                         if (ret) {
    1543                                 mwifiex_dbg(adapter, ERROR,
    1544                                             "%s: failed to send hostcmd %d\n",
    1545                                             __func__, ret);
    1546                                 return ret;
    1547                         }
    1548 
    1549                         memset(hostcmd->cmd, 0, MWIFIEX_SIZE_OF_CMD_BUFFER);
    1550                         ptr = hostcmd->cmd;
    1551                         start_raw = false;
    1552                         pos++;
    1553                         continue;
    1554                 }
    1555 

regards,
dan carpenter

