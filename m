Return-Path: <linux-wireless+bounces-20110-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D18A5971B
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 15:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C55816A07A
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 14:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5771A227BAA;
	Mon, 10 Mar 2025 14:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgW6iTWz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5D611CBA;
	Mon, 10 Mar 2025 14:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741615850; cv=none; b=qZCX6oOwI84eguVFkXp/EgJxhU8D+YbJmQy97dKID9zdrwhv+R3e5Iv0lPgHXRWIDQEp5AvEvEbsuiHFJCw38uKB2GDd1+FfhNWSXfB1F3KLYl6vc5RBF+zjwZRm77dkmexEmMr+EKQ+UmewL1Yo3j9laCGSQH+xYEsqZQnPHLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741615850; c=relaxed/simple;
	bh=QZ0yNRS89vW/MC8S75yQ51bHfUKOpWvVywpZvrYUBeE=;
	h=Date:From:To:Cc:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=df+L4/DpXHZNtPd4wCXX5tsho5Ts/fbfsMv54U3e2ouJSxzeKY6YRdC47wKbRdNakR8/XXlj6JpO7jHmoxXEQfq9S/9n0cAdXmcVgfx2YVj7JJpFs8KBDoiNmrUT6cW6IEb1dKYkXv0QE6QbC3+jRy6h/bag8ffGqdvgaZwezDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgW6iTWz; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2255003f4c6so28275265ad.0;
        Mon, 10 Mar 2025 07:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741615848; x=1742220648; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bnVaOrL5Y/iVHUk0w+Yl4ad8FoJcX+AyK8CdUNgXlIQ=;
        b=NgW6iTWzGt6k7bXGfeJGH7OD9GASrj7avvnxneaYKN1r5+00FrM5qLrMpn3r/yNu0B
         ffmUrW8jRBuKbqlePHmfMTxi/gALlwHrSslHxtHt1ylj6Lkg/8NdQ+Hz7rnnj9/kWimM
         7MxlQVyk5EnKZIdNd7LHnlXgUeYekj03zU64wJMjWi1c9hprqAi8B3aO8wyWyMNgkzKK
         /o4bqvPjec84seiKHYfa7R96Cs4ZU9zdN2fQWFzCR0H1SGItnPCK3mJX4xS2r6IDUqNN
         /s/U3uXHRlRZijLDrC0/c3I7TomSO9OfwSSz96DrlUeOGOk021IZJ/P7mjj8KLf+n6a+
         kq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741615848; x=1742220648;
        h=content-disposition:mime-version:message-id:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bnVaOrL5Y/iVHUk0w+Yl4ad8FoJcX+AyK8CdUNgXlIQ=;
        b=i/R0zxo7yDF3WylVri4XOq11z6L/o7grBMN5V1Ti5WpBLz6Ohsnes87BEREBAtpZTH
         ZKeJlhDUOBeBMJTYaXTIB2Rx+9pHLxtnJ7t1ipB/BIc+UFwfdRkbhfSyM8whPalQxTKF
         mytjYXzrxIszCeq6aLpBxqNMd8IexASRLj/46acJI6Qi5InxwqPfo5GNB6+7YI4i6T8P
         x2XVlmZ6z923/W4NvzoS+E7WbMvRV3s4BKUpZ3FjjwtngEmByHrFELhrhwE7ptiydH5y
         9cENJu3A4CR9KKU19BEjytPBuOjMC/4Z2OtVNJfN6+pttQY1DKxRf/cUBqQ/PF37ipwz
         qQ6Q==
X-Gm-Message-State: AOJu0YzeYBHBIu5Q43BokzNrJTAIQROYBbyZ++Jgq+NCaOKQu8pNOaDU
	ce08kYlDmHivIkPCnO6ic1bw9ibJsXtZIn7EMMYlyEMix79emS+jpz2QNQ==
X-Gm-Gg: ASbGnctxr6nMnJNMXm/Um03OwHSTm7nJag3dHDXUhRWKYsd1Zr/8UCzeIG1M1fNgzx8
	lyXv36kpOn/BIbFfERnMNXZ4xe3ApszOCfOfylmufTTXrd3/r9BOrAFDjl7qj3ho+x9E8GeKwx6
	e3l+nSgLwTpas7I4XwlYn8VDG8Y2KZ/HaHXUSU+0m1N4/7lXB6DfBMTOepYJ7KMViN2lEJe8z+a
	hOpkdmdVich+/SMPt7kbsIy6GBYVmuF7SJO3vl8dzyFB7+RSve06VGE0mIbqh+nXVJPWL+LjqpM
	mXlfwz5a64RLyDIA1zneOCw31UujRHSglIlNCzHoNPsyW9A=
X-Google-Smtp-Source: AGHT+IGjHZX051QxHPM+sdDBQSagoo/GbuM4PfoSGycgXcvTr94A2AbGN9aybIIJfrSJHngucJThSQ==
X-Received: by 2002:a05:6a21:3995:b0:1f5:6c94:2cce with SMTP id adf61e73a8af0-1f56c9432demr11184498637.30.1741615847565;
        Mon, 10 Mar 2025 07:10:47 -0700 (PDT)
Received: from gmail.com ([103.210.134.81])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af281287c10sm6424583a12.78.2025.03.10.07.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 07:10:47 -0700 (PDT)
Date: Mon, 10 Mar 2025 19:40:41 +0530
From: Brahmajit <brahmajit.xyz@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: linux-wireless@vger.kernel.org, johannes.berg@intel.com
Message-ID: <iu252dgt2sgg25fkuyl66r6scs5ln3fud644ept2dvtgfm2i77@6gwx3glxihja>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

ilan.peer@intel.com, miriam.rachel.korenblit@intel.com
Bcc:
Subject: Possible Null pointer dereferences in net/mac80211/parse.c
Message-ID: <auwvcgrqt34qe277qkizbyhy3oji7h3axvstnhrqbriwtltxyd@o2sgx2cwlg2x>
Reply-To:

Coverity Scan reports that there might be a possible NULL pointer
dereferences in net/mac80211/parse.c: 1061 in
ieee802_11_parse_elems_full(). I understand that these reports are not
always correct.

I'm not sure whether the syntax
struct ieee80211_elems_parse_params sub = {};
is correct or falls under C11 standard[0].

initializer:
         assignment-expression
         { initializer-list }
         { initializer-list , }
initializer-list:
         designation(opt) initializer
         initializer-list , designation(opt) initializer

I'm aware that C23 allows empty initialization[1].

braced-initializer:
                    { }
                    { initializer-list }
                    { initializer-list , }

Considering [0], if we do something like

--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -997,7 +997,7 @@ ieee80211_mle_defrag_epcs(struct ieee80211_elems_parse *elems_parse)
 struct ieee802_11_elems *
 ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params)
 {
-	struct ieee80211_elems_parse_params sub = {};
+	struct ieee80211_elems_parse_params sub = { 0 };
 	struct ieee80211_elems_parse *elems_parse;
 	const struct element *non_inherit = NULL;
 	struct ieee802_11_elems *elems;

Would it be incorrect? Would appreciate some feedback.

[0]: https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1570.pdf
[1]: https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3054.pdf
-- 
Regards,
Brahmajit

